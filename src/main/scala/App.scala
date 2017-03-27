import akka.actor.ActorSystem
import akka.http.scaladsl.Http
import akka.stream.ActorMaterializer
import scalikejdbc.config._
import utils.{Config, FlywayService}

import scala.io.StdIn

object WebServer extends Config {
  def main(args: Array[String]) {

    implicit val system = ActorSystem("my-system")
    implicit val materializer = ActorMaterializer()
    // needed for the future flatMap/onComplete in the end
    implicit val executionContext = system.dispatcher

    val httpService = new HttpAPI

    val bindingFuture = Http().bindAndHandle(httpService.routes, "0.0.0.0", port)

//    print("asd", env)
    if(env == "development"){
//      print("in")
      DBsWithEnv("development").setupAll()
    } else {
      DBsWithEnv("production").setupAll()
    }

    val flywayService = new FlywayService(jdbcUrl, dbUser, dbPassword)
    flywayService.migrateDatabaseSchema()

    println(s"Server online at http://localhost:8080/\nPress RETURN to stop...")
    StdIn.readLine()

    bindingFuture
        .flatMap(_.unbind())
          .onComplete(_=>{ DBs.closeAll(); system.terminate() })

  }
}
