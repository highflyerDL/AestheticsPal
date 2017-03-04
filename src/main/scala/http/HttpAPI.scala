import akka.http.scaladsl.server.Directives
import http.JsonSupport
import http.routes.{ExerciseAPI, ProgramAPI, TrainingDayAPI, TrainingResultAPI}

class HttpAPI extends Directives with JsonSupport {

  val exerciseRouter = new ExerciseAPI
  val programRouter = new ProgramAPI
  val trainingResultRouter = new TrainingResultAPI
  val trainingDayRouter = new TrainingDayAPI

  val routes =
    pathPrefix("api") {
      exerciseRouter.routes ~
      programRouter.routes ~
      trainingResultRouter.routes ~
      trainingDayRouter.routes
    } ~
      getFromDirectory("src/main/resources/webapp/www") ~
      get {
        getFromResource("webapp/www/index.html")
      }
}