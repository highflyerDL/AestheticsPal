package http

import akka.http.scaladsl.marshallers.sprayjson.SprayJsonSupport
import models._
import org.joda.time.DateTime
import org.joda.time.format.{DateTimeFormatter, ISODateTimeFormat}
import spray.json.{DefaultJsonProtocol, DeserializationException, JsString, JsValue, RootJsonFormat}

/**
  * Created by sharius on 3/4/17.
  */
trait JsonSupport extends SprayJsonSupport with DefaultJsonProtocol {

  implicit object DateJsonFormat extends RootJsonFormat[DateTime] {

    private val parserISO: DateTimeFormatter = ISODateTimeFormat.dateTimeNoMillis();

    override def write(obj: DateTime) = JsString(parserISO.print(obj))

    override def read(json: JsValue): DateTime = json match {
      case JsString(s) => parserISO.parseDateTime(s)
      case _ => throw new DeserializationException("Error info you want here ...")
    }
  }

  implicit val exerciseFormat = jsonFormat7(Exercise.apply)
  implicit val programFormat = jsonFormat3(Program.apply)
  implicit val programPOSTFormat = jsonFormat2(ProgramPOST)
  implicit val trainingResultFormat = jsonFormat6(TrainingResult.apply)
  implicit val trainingResultPOSTFormat = jsonFormat4(TrainingResultPOST)
  implicit val trainingDayFormat = jsonFormat4(TrainingDay.apply)
  implicit val trainingDayPOSTFormat = jsonFormat3(TrainingDayPOST)
}
