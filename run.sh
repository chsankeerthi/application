#!/bin/bash

MYSQL_PASS="OvalEdge!"
# Create a file /etc/systemd/system/docker.service.d/override.conf
[Service]
ExecStart=
ExecStart=/usr/bin/dockerd -H fd:// --group=docker


# Execute the SQL query using the mysql command-line client
service mysql start
#echo "StartingMysql"
mysql -u root -p"$MYSQL_PASS" < /home/ubuntu/scripts/MasterScripts.sql
#mv /home/ubuntu/ovaledge.war  /home/ubuntu/apache-tomcat-9.0.78/webapps
#mv /home/ubuntu/apache-tomcat-9.0.78/webapps/ovaledge/WEB-INF/classes/oasis.properties /home/ext.properties
echo 'export CATALINA_OPTS="-Dext.properties.dir=file:/home/ext.properties/"' > /home/ubuntu/apache-tomcat-9.0.78/bin/setenv.sh
chmod +x /home/ubuntu/apache-tomcat-9.0.78/bin/setenv.sh
#wget -O /home/ubuntu  https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.78/bin/apache-tomcat-9.0.78.tar.gz
#tar -zvxf apache-tomcat-9.0.78.tar.gz 
# wget -O /tmp/apache-tomcat-9.0.78.tar.gz https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.78/bin/apache-tomcat-9.0.78.tar.gz
# tar -zxvf /tmp/apache-tomcat-9.0.78.tar.gz -C /opt
# mv /opt/apache-tomcat-9.0.78 /opt/tomcat
# wget -O /opt/tomcat/webapps/ovaledge.war https://jenkins-ovaledge-s3.s3.amazonaws.com/Internal_Release6.x_OE_STANDARD/458/ovaledge.war 
sh /home/ubuntu/apache-tomcat-9.0.78/bin/startup.sh
#mv /home/ubuntu/apache-tomcat-9.0.78/webapps/ovaledge/WEB-INF/classes/oasis.properties /home/ext.properties
#echo 'export CATALINA_OPTS="-Dext.properties.dir=file:/home/ext-prop/"' > /home/ubuntu/apache-tomcat-9.0.78/bin/setenv.sh
#chmod +x /home/ubuntu/apache-tomcat-9.0.78/bin/setenv.sh
tail -f /dev/null
