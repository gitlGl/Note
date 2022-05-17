windows下安装mysql
下载网站：https://dev.mysql.com/downloads/mysql/5.7.html#downloads，选择zip下载

下载完成解压后把bin目录加入环境变量。

在根目录新建一个的ini文件，文件内配置：
[mysql]
default-character-set=utf8#设置字符编码

[mysqld]
character-set-server=utf8
default-storage-engine=INNODB#设置默认引擎默认

打开cmd输入以下命令初始化MySQLmy ，初始化成功后根目录会生成data文件夹，用作存储数据。
sqld --initialize-insecure


在cmd中输入mysqld -install 安装mysal。

输入net start mysql，启动mysql服务

输入mysqladmin -u root password 1234 ，设置root用户密码

输入mysql -uroot -p1234 登录到mysql root用户

输入net stop mysql 关闭mysql服务

卸载mysql 
先关闭mysql服务，然后输入mysqld -remove mysql，再删除环境变量与mysql安装目录

