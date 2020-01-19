FROM centos
MAINTAINER abcd<abcd@123.com>
COPY c.txt /usr/local/cincontainer.txt
ADD apache-tomcat-9.0.8.tar.gz /usr/local
ADD jdk-8u202-linux-x64.tar.gz /usr/local

RUN yum -y install vim
ENV MYPATH /usr/local
WORKDIR $MYPATH

ENV JAVA_HOME /usr/local/jdk1.8.0_202
ENV CLASSPATH $JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
ENV CATALINA_HOME /usr/local/apache-tomcat-9.0.8
ENV CATALINA_BASE /usr/local/apache-tomcat-9.0.8
ENV PATH $PATH:$JAVA_HOME/bin:$CATALINA_HOME/lib:$CATALINA_HOME/bin

EXPOSE 8080

#ENTRYPOINT["/usr/local/apache-tomcat-9.0.8/bin/startup.sh"]
#CMD["/usr/local/apache-tomcat-9.0.8/bin/catalina.sh", "run"]
CMD /usr/local/apache-tomcat-9.0.8/bin/startup.sh && tail -F /usr/local/apache-tomcat-9.0.8/bin/logs/catalina.out
