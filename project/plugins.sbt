libraryDependencies ++= Seq(
  "org.postgresql" % "postgresql" % "9.4.1212"
)

addSbtPlugin("org.scalikejdbc" %% "scalikejdbc-mapper-generator" % "2.5.0")

addSbtPlugin("io.spray" % "sbt-revolver" % "0.8.0")

addSbtPlugin("com.typesafe.sbt" % "sbt-native-packager" % "1.0.3")
