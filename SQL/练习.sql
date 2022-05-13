create table Student(SId varchar(10),Sname varchar(10),Sage datetime,Ssex varchar(10));
insert into Student values('01' , '赵雷' , '1990-01-01' , '男');
insert into Student values('02' , '钱电' , '1990-12-21' , '男');
insert into Student values('03' , '孙风' , '1990-12-20' , '男');
insert into Student values('04' , '李云' , '1990-12-06' , '男');
insert into Student values('05' , '周梅' , '1991-12-01' , '女');
insert into Student values('06' , '吴兰' , '1992-01-01' , '女');
insert into Student values('07' , '郑竹' , '1989-01-01' , '女');
insert into Student values('09' , '张三' , '2017-12-20' , '女');
insert into Student values('10' , '李四' , '2017-12-25' , '女');
insert into Student values('11' , '李四' , '2012-06-06' , '女');
insert into Student values('12' , '赵六' , '2013-06-13' , '女');
insert into Student values('13' , '孙七' , '2014-06-01' , '女');

create table Course(CId varchar(10),Cname nvarchar(10),TId varchar(10));
insert into Course values('01' , '语文' , '02');
insert into Course values('02' , '数学' , '01');
insert into Course values('03' , '英语' , '03');

create table Teacher(TId varchar(10),Tname varchar(10));
insert into Teacher values('01' , '张三');
insert into Teacher values('02' , '李四');
insert into Teacher values('03' , '王五');


create table SC(SId varchar(10),CId varchar(10),score decimal(18,1));
insert into SC values('01' , '01' , 80);
insert into SC values('01' , '02' , 90);
insert into SC values('01' , '03' , 99);
insert into SC values('02' , '01' , 70);
insert into SC values('02' , '02' , 60);
insert into SC values('02' , '03' , 80);
insert into SC values('03' , '01' , 80);
insert into SC values('03' , '02' , 80);
insert into SC values('03' , '03' , 80);
insert into SC values('04' , '01' , 50);
insert into SC values('04' , '02' , 30);
insert into SC values('04' , '03' , 20);
insert into SC values('05' , '01' , 76);
insert into SC values('05' , '02' , 87);
insert into SC values('06' , '01' , 31);
insert into SC values('06' , '03' , 34);
insert into SC values('07' , '02' , 89);
insert into SC values('07' , '03' , 98);
1.1.查询" 01 "课程比" 02 "课程成绩高的学生的信息及课程分数
1.1.1  select * from Student join  ( 
select t1.sid,t1.score as c1 ,t2.score as c2 from 
    (select SId, score  from sc where sc.CId = '01') as t1, 
    (select SId ,score  from sc where sc.CId = '02') as t2
  where t1.SId = t2.SId ) as r  on Student.SId = r.SId ;

 select * from Student,  ( 
select t1.sid,t1.score as c1 ,t2.score as c2 from 
    (select SId, score  from sc where sc.CId = '01') as t1, 
    (select SId ,score  from sc where sc.CId = '02') as t2
  where t1.SId = t2.SId ) as r where  Student.SId = r.SId ;

3.查询平均成绩大于等于 60 分的同学的学生编号和学生姓名和平均成绩
2 . select student.sid, sname ,r.avger from student join ( 
  select sid ,avg(score) as avger  from sc group by sc.Sid  having avg(score)>  60 )as r on 
  student.sid = r.sid; 

查询在 SC 表存在成绩的学生信息
3. select DISTINCT student.*#DISTINCT去重
from student,sc
where student.SId=sc.SId

查询所有同学的学生编号、学生姓名、选课总数、所有课程的成绩总和
4.select student.sid ,student.sname ,r.s1,r.s2  from student join  
(select sid,count(sid) as s1 ,sum(score)as s2 from sc group by sc.sid ) as r  
on  student.sid  = r.sid ;

查询「李」姓老师的数量
 5. select count(tid) from teacher where tname like "李%";

查询学过「张三」老师授课的同学的信息
6.select student.* ,s.CId from student,
(select sc.sid ,sc.cid from sc  where  sc.CId = '02'  group by sc.SId)as s 
where student.sid = s.sid;

//查询没有学全所有课程的同学的信息


7.查询有成绩学生且选课总数大于等于2的同学的信息

SELECT STUDENT.* FROM STUDENT,
(select ID.SID FROM  (SELECT SC.SID, count(score) as total  from sc group by sc.sid )AS ID ,
(SELECT count(course.cid) as tcid from course)  as t1 WHERE ID.TOTAL < T1.TCID)AS D WHERE STUDENT.SID = D.SID;