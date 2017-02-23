package models

import scalikejdbc._

case class Program(
  pId: Int,
  name: String,
  description: Option[String] = None,
  exercises: List[Int])

case class ProgramPOST(
  name: String,
  description: Option[String] = None,
  exercises: List[Int])

object Program extends SQLSyntaxSupport[Program] {
  override val tableName = "program"

  def apply(rs: WrappedResultSet) = new Program (
    rs.int("p_id"), rs.string("name"), rs.stringOpt("description"),
    rs.array("exercises").getArray.asInstanceOf[Array[Int]].toList
  )

  def getAll()(implicit session: DBSession = autoSession): List[Program] =
    sql"select * from program".map(rs => Program(rs)).list.apply()

  def create(name: String, description: Option[String], exercises: List[Int])(implicit session: DBSession = autoSession): Program = {
    val id = sql"""insert into program(name, description, exercises) VALUES(${name}, ${description}, ARRAY[${exercises}])""".updateAndReturnGeneratedKey().apply()

    Program.apply(id.toInt, name, description, exercises)
  }

  def edit(p: Program)(implicit session: DBSession = autoSession): Long =
    sql"""update program set(name, description, exercises)  = (${p.name}, ${p.description}, ${p.exercises})
         where p_id = ${p.pId}""".update().apply()

  def getById(programId: Int)(implicit session: DBSession = autoSession): List[Program] =
    sql"select * from program where p_id = ${programId}".map(rs => Program(rs)).list.apply()
}



