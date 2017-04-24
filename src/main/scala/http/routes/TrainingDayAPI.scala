package http.routes

import akka.http.scaladsl.model.StatusCodes
import akka.http.scaladsl.server.Directives
import http.JsonSupport
import models.{TrainingDay, TrainingDayPOST}

/**
  * Created by sharius on 3/4/17.
  */
class TrainingDayAPI extends Directives with JsonSupport{
  val routes =
    path("trainingday") {
      get {
        complete(TrainingDay.getAll())
      } ~
        post {
          entity(as[TrainingDayPOST]) { trainingDay =>
            TrainingDay.create(trainingDay.pId, trainingDay.name, trainingDay.exercises) match {
              case trainingDay: TrainingDay=> complete("""Training day created""")
              case _ => complete(StatusCodes.NotAcceptable -> "Error creating training day")
            }
          }
        }
    } ~
      path("trainingday" / "day" / IntNumber) { dayId =>
        get {
          complete(TrainingDay.getByDayId(dayId))
        }
      } ~
      path("trainingday" / "program" / IntNumber) { programId =>
        get {
          complete(TrainingDay.getByProgramId(programId))
        }
      }
}
