import akka.actor.ActorSystem
import akka.http.scaladsl.Http
import akka.http.scaladsl.marshallers.sprayjson.SprayJsonSupport
import akka.http.scaladsl.model.{ContentTypes, HttpEntity}
import akka.stream.ActorMaterializer
import akka.http.scaladsl.model._
import akka.http.scaladsl.server.Directives
import models._
import org.joda.time.format.{DateTimeFormatter, ISODateTimeFormat}
import scalikejdbc.config._
import spray.json.{DefaultJsonProtocol, DeserializationException, JsString, JsValue, RootJsonFormat}
import org.joda.time.{DateTime, DateTimeZone}

import scala.io.StdIn

object WebServer {
  def main(args: Array[String]) {

    implicit val system = ActorSystem("my-system")
    implicit val materializer = ActorMaterializer()
    // needed for the future flatMap/onComplete in the end
    implicit val executionContext = system.dispatcher

    trait JsonSupport extends SprayJsonSupport with DefaultJsonProtocol {
      implicit object DateJsonFormat extends RootJsonFormat[DateTime] {

        private val parserISO : DateTimeFormatter = ISODateTimeFormat.dateTimeNoMillis();

        override def write(obj: DateTime) = JsString(parserISO.print(obj))

        override def read(json: JsValue) : DateTime = json match {
          case JsString(s) => parserISO.parseDateTime(s)
          case _ => throw new DeserializationException("Error info you want here ...")
        }
      }
      implicit val exerciseFormat = jsonFormat7(Exercise.apply)
      implicit val programFormat = jsonFormat4(Program.apply)
      implicit val programPOSTFormat = jsonFormat3(ProgramPOST)
      implicit val trainingResultFormat = jsonFormat6(TrainingResult.apply)
      implicit val trainingResultPOSTFormat = jsonFormat4(TrainingResultPOST)
    }

    class ExerciseService extends Directives with JsonSupport {
      val route =
        path("exercise") {
          get {
            complete(Exercise.getAll())
          }
        } ~
        pathPrefix("exercise" / IntNumber) { categoryId =>
          get {
            complete(Exercise.getByCategory(categoryId))
          }
        } ~
        path("programexercise") {
          get {
            parameter('id.as[Int].*) { listOfIds =>
              complete(Exercise.getByIds(listOfIds.toList))
            }
          }
        } ~
        path("program") {
          get {
            complete(Program.getAll())
          }
          post {
            entity(as[ProgramPOST]) { program =>
              Program.create(program.name, program.description, program.exercises) match {
                case program: Program => complete("Program created")
                case _ => complete(StatusCodes.NotAcceptable -> "Error creating program")
              }
            }
          }
        } ~
        path("trainingresult") {
          get {
            complete(TrainingResult.getAll())
          }
          post {
            entity(as[TrainingResultPOST]) { tr =>
              TrainingResult.create(tr.pId, tr.eId, tr.repCount, tr.weight) match {
                case tResult: TrainingResult=> complete("Result created")
                case _ => complete(StatusCodes.NotAcceptable -> "Error creating result")
              }
            }
          }
        }
        pathPrefix("trainingresult" / IntNumber) { programId =>
          get {
            complete(TrainingResult.getByProgram(programId))
          }
        }
    }

    val eService = new ExerciseService

    val bindingFuture = Http().bindAndHandle(eService.route, "localhost", 8080)
    DBs.setupAll()

    println(s"Server online at http://localhost:8080/\nPress RETURN to stop...")
    StdIn.readLine()

    bindingFuture
        .flatMap(_.unbind())
          .onComplete(_=>{ DBs.closeAll(); system.terminate() })

  }
}
