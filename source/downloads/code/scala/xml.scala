val hdfs = scala.xml.XML.loadFile("hdfs-site.xml")

val hdfs_properties = hdfs \ "property"

(hdfs_properties \ "_").foreach { hdfs => 
	hdfs match {
		case <name>{hdfsPropertyName}</name> => println("Property: " + hdfsPropertyName)
		case <value>{hdfsPropertyValue}</value> => println("Value: " + hdfsPropertyValue)
	}
}