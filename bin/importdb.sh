#!/usr/bin/env bash
mysql -u root -p$MYSQL_ROOT_PASSWORD < /tmp/create-db.sql
mysql -u root -p$MYSQL_ROOT_PASSWORD < /tmp/dump.sql