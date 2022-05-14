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

查询至少有一门课与学号为" 01 "的同学所学相同的同学的信息
select * from student 
where student.sid in (
    select sc.sid from sc 
    where sc.cid in(
        select sc.cid from sc 
        where sc.sid = '01'
    )
);
10.查询没学过"张三"老师讲授的任一门课程的学生姓名
select student.sname from student where sid not in(
select sid  from sc ,
(select cid  from course ,
(select tid from teacher where tname = '张三') as id
where course.TId = id.tid) as cid1 where sc.cid = cid1.cid);
查询学生的总成绩，并进行排名
select student.sid,student.sname,r.s from student ,
(select sid,sum(score) as s  from sc group by sid)  as r 
where student.sid = r.sid order by r.s desc;

查询各科目优秀人数，分数在85分以上的人数为优秀
select r.cid, r.cname, sum(case when  r.score >= 85 and r.score <= 100 then 1 else 0 end )as "优秀"
from 
 (select *  from sc  join course
on sc.cid = course.cid) as r group by r.cid
 ;
 
 查询语文成绩前三名
select student.Sname, sc.sid ,sc.score from student ,sc,
(select cid from co where cname = '语文') as b 
where (sc.cid = b.cid and student.sid = sc.sid) order by score desc limit 3;

查询各科成绩最高分、最低分和平均分：
select max(score)as '最高分',min(score) as '最低分',avg(score) as '平均分' from sc group by sc.cid;

查询每门课程被选修的学生数
select sc.cid,sum(sc.sid) from sc group by sc.CId ;

查询男生数、女生数量
select ssex ,count(sid) from student group by ssex;

查询名字含有风的学生的信息
select  * from student where sname  like '%风%';

查询同名学生数量

select r.sname,r.num from (select  student.*,count(sname) as num  from student group by sname) as r
where r.num >1;

嵌套查询列出同名的全部学生的信息
select * from student
where sname in (
select sname from student
group by sname
having count(*)>1
);

查询平均成绩大于等于 85 的所有学生的学号、姓名和平均成绩
 select student .*,r.avger from 
 (select   sid, avg(score)as avger  from sc group by sid)as r,student  
 where student.sid = r.sid and r.avger >= 85;
 
 select student.sid, student.sname, AVG(sc.score) as aver from student, sc
where student.sid = sc.sid
group by sc.sid
having aver > 85;

 select student.sid,student.sname,r.* from (select  sid ,score ,sc.cid from sc where sc.cid = '01' and sc.score >= 80)as r,student where student.sid = r.sid;
 
 查询课程编号为 01 且课程成绩在 80 分及以上的学生的学号和姓名
 select student.sid,student.sname ,sc.score
from student,sc
where cid="01"
and score>=80
and student.sid = sc.sid

