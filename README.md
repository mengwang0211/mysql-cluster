# MySQL 集群

https://www.khs1994.com/database/mysql/cluster.html

```bash
$ docker-compose up -d

# 查看子节点数据库

$ docker-compose exec mysql_node mysql \
    -uroot \
    -pmytest \
    -e 'show databases;'

# 在主节点新建数据库

$ docker-compose exec mysql_master mysql \
    -uroot \
    -pmytest \
    -e 'create database test;'

# 再次查看子节点数据库，发现数据已经同步    

$ docker-compose exec mysql_node mysql \
    -uroot \
    -pmytest \
    -e 'show databases;'
```

# 参考链接

* https://github.com/TomCzHen/mysql-replication-sample

* https://juejin.im/post/5a2e4bd66fb9a044fa19cfb7
