FROM docker.io/aoqi/loongson-openjdk:loongson3a-loongnix-8.1.1-jdk8u192

#添加初始化脚本到镜像的根目录下
ADD MongodbManager.war /
ADD tomcat8.tar  / 
#安装所需软件
RUN     yum install -y tar bzip2  \
   &&   mv /MongodbManager.war  /tomcat8.0/webapps/  \
   &&   ln -s  /tomcat8.0/bin/startup.sh  /bin/tomcatstart \
   &&   ln -s  /tomcat8.0/bin/shutdown.sh  /bin/tomcatstop \
   &&   yum clean all 
                    
#设置容器对外端口
EXPOSE 8080
EXPOSE 80
EXPOSE 8081
# overwrite this with 'CMD []' in a dependent Dockerfile
#默认不启动mongodb-client（二选一）
#CMD ["/bin/bash"]
#默认启动mongobd-client （二选一）
CMD ["/bin/tomcatstart"]
