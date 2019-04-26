FROM docker.io/aoqi/loongson-openjdk:loongson3a-loongnix-8.1.1-jdk8u192

#添加初始化脚本到镜像的根目录下
ADD MongodbManager.war /
ADD tomcat8.tar  / 
ADD init.sh  / 
#安装所需软件
RUN     yum install -y tar bzip2  \
   &&   chmod a+x /init.sh  \
   &&   rm -rf /tomcat8.0/webapps/ROOT/*  &&  mv /MongodbManager.war  /tomcat8.0/webapps/ROOT/   \
   &&   cd /tomcat8.0/webapps/ROOT/ && jar xf MongodbManager.war \
   &&   ln -s  /tomcat8.0/bin/startup.sh  /bin/tomcatstart \
   &&   ln -s  /tomcat8.0/bin/shutdown.sh  /bin/tomcatstop \
   &&   yum clean all 

ENV JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.192-1.b12.8.1.1.fc21.loongson.mips64el
ENV JRE_HOME=$JAVA_HOME/jre
ENV CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar:$JRE_HOME/lib:$CLASSPATH

#设置容器对外端口
EXPOSE 8080
EXPOSE 80
EXPOSE 8081
# overwrite this with 'CMD []' in a dependent Dockerfile
#默认不启动mongodb-client（二选一）
#CMD ["/bin/bash"]
#默认启动mongobd-client （二选一）
#CMD ["/init.sh"]
CMD ["/tomcat8.0/bin/catalina.sh","run"]
