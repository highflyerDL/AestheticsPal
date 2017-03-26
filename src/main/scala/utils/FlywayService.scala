package utils

import org.flywaydb.core.Flyway

/**
  * Created by sharius on 3/25/17.
  */
class FlywayService(jdbcUrl: String, dbUser: String, dbPassword: String) {
  private val flyway = new Flyway()
  flyway.setDataSource(jdbcUrl, dbUser, dbPassword)

  def migrateDatabaseSchema() : Unit = flyway.migrate()

  def dropDatabase() : Unit = flyway.clean()
}
