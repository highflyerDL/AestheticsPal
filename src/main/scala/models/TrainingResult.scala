package models

import org.joda.time.DateTime
import scalikejdbc._

/**
  * Created by sharius on 2/18/17.
  */

case class TrainingResult (
  trId: Int, pId: Int, eId: Int,
  trainedOn: DateTime,
  repCount: Int, weight: Int
)

case class TrainingResultPOST (
  pId: Int, eId: Int,
  repCount: Int, weight: Int
)

object TrainingResult extends SQLSyntaxSupport[TrainingResult]{
  override val tableName = "training_result"
  def apply(rs: WrappedResultSet) = new TrainingResult(
    rs.int("tr_id"), rs.int("p_id"), rs.int("e_id"),
    rs.jodaDateTime("trained_on"),
    rs.int("rep_count"), rs.int("weight")
  )

  def getAll()(implicit session: DBSession = autoSession): List[TrainingResult] =
    sql"select * from training_result".map(rs => TrainingResult(rs)).list.apply()

  def getByProgram(programId: Int)(implicit session: DBSession = autoSession): List[TrainingResult] =
    sql"select * from training_result where p_id = ${programId}".map(rs => TrainingResult(rs)).list.apply()

  def create(pId: Int, eId: Int, repCount: Int, weight: Int)(implicit session: DBSession = autoSession): TrainingResult = {
    val now = DateTime.now()
    val id = sql"""insert into training_result(p_id, e_id, trained_on, rep_count, weight) VALUES(${pId}, ${eId}, current_date, ${repCount}, ${})""".updateAndReturnGeneratedKey().apply()

    TrainingResult.apply(id.toInt, pId, eId, now, repCount, weight)
  }
}
