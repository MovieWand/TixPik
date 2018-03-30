
# ### Access to mysql-server container

docker exec -it mysql-server mysql -uroot -ptixpik@123456

#  Enter password: tixpik@123456 to access root mysql

# Show all databases
show databases;

# Use MovieWand database
use MovieWand;

# Show all table in MovieWand database
show tables;

# Import data from csv to table
# Link: https://dev.mysql.com/doc/refman/5.7/en/load-data.html

load data local infile 'company.csv' into table Company fields terminated by '@' lines terminated by '\n';




