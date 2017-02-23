package models

import scalikejdbc._

case class Exercise(eId: Int, name: String, description: Option[String] = None, muscle: List[String], muscleSecondary: List[String], image: List[String], category: Int)

object Exercise extends SQLSyntaxSupport[Exercise] {
  override val tableName = "exercise"
  def apply(rs: WrappedResultSet) = new Exercise (
    rs.int("e_id"), rs.string("name"), rs.stringOpt("description"),
    rs.array("muscle").getArray.asInstanceOf[Array[String]].toList,
    rs.array("muscle_secondary").getArray.asInstanceOf[Array[String]].toList,
    rs.array("image").getArray.asInstanceOf[Array[String]].toList,
    rs.int("category")
  )

  def getAll()(implicit session: DBSession = autoSession): List[Exercise] =
    sql"select * from exercise".map(rs => Exercise(rs)).list.apply()

  def getByCategory(categoryId: Int)(implicit session: DBSession = autoSession): List[Exercise] =
    sql"select * from exercise where category = ${categoryId}".map(rs => Exercise(rs)).list.apply()

  def getByIds(ids: List[Int])(implicit session: DBSession = autoSession): List[Exercise] =
    sql"select * from exercise where e_id in (${ids})".map(rs => Exercise(rs)).list.apply()
}



