# DockerFile
執行dockerfile前
下載這包

```
sudo wget https://archive.apache.org/dist/tomcat/tomcat-9/v9.0.8/bin/apache-tomcat-9.0.8.tar.gz
```

和這包

```
jdk-8u202-linux-x64.tar.gz
```

用官網下載前要登入, 沒辦法wget ,所以先載好再丟到server中

如果兩包的版本有不同 就修改dockerfile的 這5行 修改成相應的版本
```
ADD apache-tomcat-9.0.8.tar.gz /usr/local
ADD jdk-8u202-linux-x64.tar.gz /usr/local
...
ENV JAVA_HOME /usr/local/jdk1.8.0_202
...
ENV CATALINA_HOME /usr/local/apache-tomcat-9.0.8
ENV CATALINA_BASE /usr/local/apache-tomcat-9.0.8
```
