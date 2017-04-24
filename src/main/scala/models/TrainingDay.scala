package models

import scalikejdbc._

/**
  * Created by sharius on 2/18/17.
  */

case class TrainingDay (
  tdId: Int, pId: Int,
  name: String,
  exercises: List[Int]
)

case class TrainingDayPOST (
  pId: Int,
  name: String,
  exercises: List[Int]
)

object TrainingDay extends SQLSyntaxSupport[TrainingDay]{
  override val tableName = "training_day"
  def apply(rs: WrappedResultSet) = new TrainingDay(
    rs.int("td_id"), rs.int("p_id"),
    rs.string("name"),
    rs.array("exercises").getArray.asInstanceOf[Array[Integer]].map(_.intValue()).toList
  )

  def getAll()(implicit session: DBSession = autoSession): List[TrainingDay] =
    sql"select * from training_day".map(rs => TrainingDay(rs)).list.apply()

  def getByDayId(dayId: Int)(implicit session: DBSession = autoSession): List[TrainingDay] =
    sql"select * from training_day where td_id = ${dayId}".map(rs => TrainingDay(rs)).list.apply()

  def create(pId: Int, name: String, exercises: List[Int])(implicit session: DBSession = autoSession): TrainingDay = {
    val id = sql"""insert into training_day(p_id, name, exercises) VALUES(${pId}, ${name}, ARRAY[${exercises}])""".updateAndReturnGeneratedKey().apply()

    TrainingDay.apply(id.toInt, pId, name, exercises)
  }
}
