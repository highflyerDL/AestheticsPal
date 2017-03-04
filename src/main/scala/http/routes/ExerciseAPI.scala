package http.routes

import akka.http.scaladsl.server.Directives
import http.JsonSupport
import models.Exercise

/**
  * Created by sharius on 3/4/17.
  */
class ExerciseAPI extends Directives with JsonSupport {
  val routes =
    path("exercise") {
      get {
        complete(Exercise.getAll())
      }
    } ~
      path("exercise" / IntNumber) { categoryId =>
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
      }
}
