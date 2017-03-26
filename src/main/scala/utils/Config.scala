package utils

import com.typesafe.config.ConfigFactory

/**
  * Created by sharius on 3/5/17.
  */
trait Config {
  val env = if (System.getenv("SCALA_ENV") == null) "development" else "production"
  val port = if (System.getenv("SCALA_PORT") == null) 8080 else System.getenv("SCALA_PORT").toInt

  private val config = ConfigFactory.load()
  private val envConfig = config.getConfig(env)
  private val databaseConfig = envConfig.getConfig("db")

  val jdbcUrl = databaseConfig.getString("default.url")
  val dbUser = databaseConfig.getString("default.user")
  val dbPassword = databaseConfig.getString("default.password")
}
