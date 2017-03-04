package models

import scalikejdbc._

case class Program(
  pId: Int,
  name: String,
  description: Option[String] = None)

case class ProgramPOST(
  name: String,
  description: Option[String] = None)

object Program extends SQLSyntaxSupport[Program] {
  override val tableName = "program"

  def apply(rs: WrappedResultSet) = new Program (
    rs.int("p_id"), rs.string("name"), rs.stringOpt("description")
  )

  def getAll()(implicit session: DBSession = autoSession): List[Program] =
    sql"select * from program".map(rs => {Program(rs)}).list.apply()

  def create(name: String, description: Option[String])(implicit session: DBSession = autoSession): Program = {
    val id = sql"""insert into program(name, description) VALUES(${name}, ${description})""".updateAndReturnGeneratedKey().apply()

    Program.apply(id.toInt, name, description)
  }

  def edit(p: Program)(implicit session: DBSession = autoSession): Long =
    sql"""update program set(name, description)  = (${p.name}, ${p.description})
         where p_id = ${p.pId}""".update().apply()

  def getById(programId: Int)(implicit session: DBSession = autoSession): List[Program] =
    sql"select * from program where p_id = ${programId}".map(rs => Program(rs)).list.apply()
}



