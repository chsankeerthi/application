FROM ubuntu:latest

RUN apt-get update
RUN apt install wget -y
RUN  mkdir -p /home/ubuntu/scripts/
RUN mkdir -p /home/ext.properties/
RUN mkdir -p /home/ubuntu/apache-tomcat-9.0.78/webapps
#RUN touch /home/ubuntu/apache-tomcat-9.0.78/bin/setenv.sh
#RUN chmod +x  /home/ubuntu/apache-tomcat-9.0.78/bin/setenv.sh
RUN  mkdir /opt/tomcat
# Download the SQL script
#RUN wget -O /home/ubuntu/scripts/MasterScripts.sql https://ovaledge.s3.us-west-1.amazonaws.com/OvalEdge+Clients/Celebal/MasterScripts.sql
RUN apt-get update && apt-get install -y openjdk-8-jdk
#RUN wget -O /home/ubuntu/scripts/MasterScripts.sql https://ovaledge.s3.us-west-1.amazonaws.com/OvalEdge+Clients/Celebal/MasterScripts.sqlRu
RUN apt-get update
RUN apt install mysql-server -y
#RUN service mysql start

# MySQL credentials
RUN export MYSQL_PASS="OvalEdge!"
#RUN wget  https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.78/bin/apache-tomcat-9.0.78.tar.gz

#RUN tar -zvxf /home/ubuntu/scripts/apache-tomcat-9.0.78.tar.gz  -C /home/ubuntu/scriptsRUN wget  https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.78/bin/apache-tomcat-9.0.78.tar.gz
#RUN wget https://jenkins-ovaledge-s3.s3.amazonaws.com/Internal_Release6.x_OE_STANDARD/458/ovaledge.war -O /home/ubuntu/scripts/apache-tomcat-9.0.78.tar.gz/webapps/ovaledge.war
RUN wget -O /home/ubuntu/apache-tomcat-9.0.78.tar.gz https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.78/bin/apache-tomcat-9.0.78.tar.gz
RUN tar -zxvf /home/ubuntu/apache-tomcat-9.0.78.tar.gz -C /home/ubuntu/
#COPY ovaledge.war /home/ubuntu/
COPY ovaledge.war /home/ubuntu/apache-tomcat-9.0.78/webapps/ovaledge.war
COPY oasis.properties /home/ext.properties/
#RUN chmod +x /opt/tomcat/bin/startup.sh
COPY run.sh /home/ubuntu/scripts/run.sh
COPY MasterScripts.sql /home/ubuntu/scripts/MasterScripts.sql
RUN chmod +x  /home/ubuntu/scripts/run.sh
RUN chmod 777 -R  /home/ubuntu/apache-tomcat-9.0.78
EXPOSE 8080
CMD [ "/home/ubuntu/apache-tomcat-9.0.78/bin/startup.sh"]

#RUN apt install wget
#RUN wget https://ovaledge.s3.us-west-1.amazonaws.com/OvalEdge+Clients/Celebal/MasterScripts.sql -p /home/ubuntu/scripts                                                                                  
ENTRYPOINT ["/home/ubuntu/scripts/run.sh"]

