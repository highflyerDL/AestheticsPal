import scalikejdbc._

object DBInitializer {

  def run() {
    DB readOnly { implicit s =>
      try {
        sql"select 1 from exercise limit 1".map(_.long(1)).single.apply()
      } catch {
        case e: java.sql.SQLException =>
          DB autoCommit { implicit s =>
            sql"""
   """.execute.apply()
          }
      }
    }
  }

}