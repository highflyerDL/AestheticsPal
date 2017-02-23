package models

import scalikejdbc.specs2.mutable.AutoRollback
import org.specs2.mutable._
import scalikejdbc._


class ProgramSpec extends Specification {

  "Program" should {

    val p = Program.syntax("p")

    "find by primary keys" in new AutoRollback {
      val maybeFound = Program.find(123)
      maybeFound.isDefined should beTrue
    }
    "find by where clauses" in new AutoRollback {
      val maybeFound = Program.findBy(sqls.eq(p.pId, 123))
      maybeFound.isDefined should beTrue
    }
    "find all records" in new AutoRollback {
      val allResults = Program.findAll()
      allResults.size should be_>(0)
    }
    "count all records" in new AutoRollback {
      val count = Program.countAll()
      count should be_>(0L)
    }
    "find all by where clauses" in new AutoRollback {
      val results = Program.findAllBy(sqls.eq(p.pId, 123))
      results.size should be_>(0)
    }
    "count by where clauses" in new AutoRollback {
      val count = Program.countBy(sqls.eq(p.pId, 123))
      count should be_>(0L)
    }
    "create new record" in new AutoRollback {
      val created = Program.create(name = "MyString")
      created should not beNull
    }
    "save a record" in new AutoRollback {
      val entity = Program.findAll().head
      // TODO modify something
      val modified = entity
      val updated = Program.save(modified)
      updated should not equalTo(entity)
    }
    "destroy a record" in new AutoRollback {
      val entity = Program.findAll().head
      val deleted = Program.destroy(entity) == 1
      deleted should beTrue
      val shouldBeNone = Program.find(123)
      shouldBeNone.isDefined should beFalse
    }
    "perform batch insert" in new AutoRollback {
      val entities = Program.findAll()
      entities.foreach(e => Program.destroy(e))
      val batchInserted = Program.batchInsert(entities)
      batchInserted.size should be_>(0)
    }
  }

}
