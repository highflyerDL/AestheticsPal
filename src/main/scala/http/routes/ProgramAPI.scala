package http.routes

import akka.http.scaladsl.model.StatusCodes
import akka.http.scaladsl.server.Directives
import http.JsonSupport
import models.{Program, ProgramPOST}

/**
  * Created by sharius on 3/4/17.
  */
class ProgramAPI extends Directives with JsonSupport {
  val routes =
    path("program") {
      get {
        complete(Program.getAll())
      } ~
        post {
          entity(as[ProgramPOST]) { program =>
            Program.create(program.name, program.description, program.days) match {
              case program: Program => complete("""Program created""")
              case _ => complete(StatusCodes.NotAcceptable -> "Error creating program")
            }
          }
        }
    } ~
      path("program" / IntNumber) { programId =>
        get {
          complete(Program.getById(programId))
        }
      }
}
