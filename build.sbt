name := "AestheticPal"

organization := "example"

version := "0.1.0-SNAPSHOT"

scalaVersion := "2.11.8"

crossScalaVersions := Seq("2.10.4", "2.11.2")

libraryDependencies ++= Seq(
  "com.typesafe.akka" %% "akka-http"            % akkaHttpVersion,
  "com.typesafe.akka" %% "akka-http-spray-json" % akkaHttpVersion,
  "org.scalikejdbc" %% "scalikejdbc"            % scalikeJDBCVersion,
  "org.scalikejdbc" %% "scalikejdbc-config"     % scalikeJDBCVersion,
  "org.flywaydb" % "flyway-core" % "3.2.1",
  "ch.qos.logback"  %  "logback-classic"   % "1.1.7",
  "org.postgresql" % "postgresql" % "9.4.1212"
)

initialCommands :=
  """
    println("hello")
    import scalikejdbc._, config._
    import utils._
    DBs.setupAll()
    DBInitializer.run()
    implicit val autoSession = AutoSession
  """

scalikejdbcSettings

enablePlugins(JavaAppPackaging)
lazy val akkaHttpVersion = "10.0.3"
lazy val scalikeJDBCVersion = "2.5.0"
