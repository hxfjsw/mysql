FROM centos:latest

RUN yum -y install epel-release
RUN yum -y update
RUN yum -y install wget gcc-c++ pcre-devel openssl openssl-devel python cmake gdb python-setuptools crontabs supervisor unzip autoconf libxslt-devel
RUN yum -y install bison l libxml2 libxml2-devel libcurl libcurl-devel openjpeg openjpeg-devel libjpeg-devel libpng-devel freetype-devel libicu-devel l libmcrypt libmcrypt-devel mcrypt mhash

RUN wget http://downloads.sourceforge.net/project/boost/boost/1.59.0/boost_1_59_0.tar.gz
RUN wget http://cdn.mysql.com/Downloads/MySQL-5.7/mysql-5.7.9.tar.gz

RUN tar xzf boost_1_59_0.tar.gz
RUN tar xzf mysql-5.7.9.tar.gz

RUN mkdir -p /data/mysql
RUN cmake . -DCMAKE_INSTALL_PREFIX=/usr/local/mysql \
-DMYSQL_DATADIR=/data/mysql \
-DDOWNLOAD_BOOST=1 \   #从MySQL 5.7.5开始Boost库是必需的
-DWITH_BOOST=../boost_1_59_0 \
-DSYSCONFDIR=/etc \
-DWITH_INNOBASE_STORAGE_ENGINE=1 \
-DWITH_PARTITION_STORAGE_ENGINE=1 \
-DWITH_FEDERATED_STORAGE_ENGINE=1 \
-DWITH_BLACKHOLE_STORAGE_ENGINE=1 \
-DWITH_MYISAM_STORAGE_ENGINE=1 \
-DENABLED_LOCAL_INFILE=1 \
-DENABLE_DTRACE=0 \
-DDEFAULT_CHARSET=utf8mb4 \
-DDEFAULT_COLLATION=utf8mb4_general_ci \
-DWITH_EMBEDDED_SERVER=1