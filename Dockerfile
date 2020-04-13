# 指定ubutu为基础镜像
FROM ubuntu
# 设置镜像作者:mh
MAINTAINER cwy
# 创建Docker容器中,Java环境的存放目录
RUN mkdir /usr/local/java
# 创建Docker容器中,Tomcat环境的存放目录
RUN mkdir /usr/local/tomcat
# 解压安装文件到Java环境的存放目录
ADD jdk-8u131-linux-x64.tar.gz /usr/local/java/
# 解压Tomcat安装文件到Java环境的存放目录
ADD apache-tomcat-7.0.57.tar.gz /usr/local/tomcat/
# 创建目录的同步链接
RUN ln -s /usr/local/java/jdk1.8.0_131 /usr/local/java/jdk
RUN ln -s /usr/local/tomcat/apache-tomcat-7.0.57 /usr/local/tomcat/tomcat7
# 设置环境变量
ENV JAVA_HOME=/usr/local/java/jdk
ENV CLASSPATH=.:${JAVA_HOME}/lib/tools.jar:${JAVA_HOME}/lib/dt.jar
ENV CATALINA_HOME=/usr/local/tomcat/tomcat7
ENV PATH=$PATH:${JAVA_HOME}/bin:${CATALINA_HOME}/bin
# 设置War文件的相对路径
COPY war/big.war /usr/local/tomcat/apache-tomcat-7.0.57/webapps
COPY server.xml /usr/local/tomcat/tomcat7/conf
# 容器运行时监听的端口
EXPOSE 8080
# 启动时运行tomcat
ENTRYPOINT ["/usr/local/tomcat/tomcat7/bin/catalina.sh","run"]
