mkdir -p $(pwd)/webapps
docker run -d --name jetty-server -p 8080:8080 -p 443:8443 --link mysql-server:mysql-server -v $(pwd)/webapps:/var/lib/jetty/webapps jetty
