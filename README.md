# DockerFile For tomcat
執行dockerfile前
下載這包

```
sudo wget https://archive.apache.org/dist/tomcat/tomcat-9/v9.0.8/bin/apache-tomcat-9.0.8.tar.gz
```

和這包

```
jdk-8u202-linux-x64.tar.gz
```

jdk用官網下載前要登入, 沒辦法wget, 所以先載好再丟到server中

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
build Dockerfile(在git裡面)

執行git裡面 DockerCommend 內的指令


進nginx 設定
```
server {
        listen 8080;

        server_name _;

        root /var/www/;
        index index.html index.htm index.jsp;

        location / {
                index index.jsp;
               proxy_pass http://127.0.0.1:9080;#轉向tomcat container處理
        }
}
```


進入容器
(如果版號不同 自行指定)
```
cd apache-tomcat-9.0.8/
cd conf
```

## 配置以下參數 以便進入 tomcat的manager app

編輯xml
```
vim tomcat-users.xml
```

加入以下權限與用戶名(username 與 password可以改)

```
<role rolename="manager"/>
<role rolename="manager-gui"/>
<role rolename="admin"/>
<role rolename="admin-gui"/>
<role rolename="manager-script"/>
<role rolename="manager-jmx"/>
<role rolename="manager-status"/>
<user username="tomcat" password="tomcat" roles="admin-gui,admin,manager-gui,manager,manager-script,manager-jmx,manager-status"/>
```

再進入以下目錄
```
/usr/local/apache-tomcat-9.0.8/webapps/manager/META-INF
```
修改以下檔案
```
vim context.xml
```

將Valve 標籤註解

```
<!--  <Valve className="org.apache.catalina.valves.RemoteAddrValve"
         allow="127\.\d+\.\d+\.\d+|::1|0:0:0:0:0:0:0:1" />-->
```

# 虛擬目錄配置

編輯conf 的server.xml

<Host>節點間 添加以下代碼 會把/myweb路由 指向f槽的myweb目錄下
```        
<Context paty="/myweb" docBase="f:\myweb"/>
```




