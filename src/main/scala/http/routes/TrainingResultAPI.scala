package http.routes

import akka.http.scaladsl.model.StatusCodes
import akka.http.scaladsl.server.Directives
import http.JsonSupport
import models.{TrainingResult, TrainingResultPOST}

/**
  * Created by sharius on 3/4/17.
  */
class TrainingResultAPI extends Directives with JsonSupport {
  val routes =
    path("trainingresult") {
      get {
        complete(TrainingResult.getAll())
      } ~
        post {
          entity(as[TrainingResultPOST]) { tr =>
            TrainingResult.create(tr.tdId, tr.eId, tr.repCount, tr.weight) match {
              case tResult: TrainingResult=> complete("Result created")
              case _ => complete(StatusCodes.NotAcceptable -> "Error creating result")
            }
          }
        }
    } ~
      path("trainingresult" / IntNumber) { dayId =>
        get {
          complete(TrainingResult.getByDay(dayId))
        }
      }
}
