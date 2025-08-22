
--Task 1

declare @Students table(
student_id int primary key,
first_name varchar(20),
middle_name varchar(20),
last_name varchar(20),
gender varchar(10),
DOB date,
personal_phone varchar(20),
email varchar(50)
);

declare @SummerCamp table(
camp_id int primary key,
camp_title varchar(50),
start_date date,
end_date date,
capacity int,
price decimal(10,2)
);

declare @Registartions table(
registration_id int primary key,
student_id int,
camp_id int
);


--Task 2

-- Female Names (65 % of 5000 is 3250, 13*10*25 = 3250)
declare @Female_first_names table(id int, name  varchar(20));
insert into @Female_first_names values 
(1,'Priya'),(2,'Ananya'),(3,'Kavya'),(4,'Aadhya'),(5,'Diya'),(6,'Arya'),(7,'Ishika'),
(8,'Saanvi'),(9,'Anika'),(10,'Riya'),(11,'Kiara'),(12,'Navya'),(13,'Myra');

declare @Female_middle_names table(id int, name varchar(20));
insert into @Female_middle_names values 
(1,'Devi'),(2,'Kumari'),(3,'Rani'),(4,'Bala'),(5,'Shree'),(6,'Lakshmi'),
(7,'Sai'),(8,'Mala'),(9,'Vani'),(10,'Ganga');


declare @Female_last_names table(id int, name varchar(20));
insert into @Female_last_names values 
(1,'Sharma'),(2,'Patel'),(3,'Singh'),(4,'Kumar'),(5,'Gupta'),(6,'Agarwal'),
(7,'Reddy'),(8,'Nair'),(9,'Iyer'),(10,'Mehta'),(11,'Joshi'),(12,'Rao'),
(13,'Chopra'),(14,'Bansal'),(15,'Malhotra'),(16,'Sinha'),(17,'Verma'),(18,'Tiwari'),
(19,'Mishra'),(20,'Pandey'),(21,'Shah'),(22,'Kapoor'),(23,'Aggarwal'),(24,'Jain'),(25,'Khanna');

-- Male Names (35% of 5000 is 1750, 10*7*25=1750)  
declare @Male_first_names table(id int, name varchar(20));
insert into @Male_first_names values
(1,'Arjun'),(2,'Aarav'),(3,'Vihaan'),(4,'Aditya'),(5,'Rohan'),(6,'Kiran'),
(7,'Rahul'),(8,'Vikram'),(9,'Ravi'),(10,'Suresh');

declare @Male_middle_names table(id int, name varchar(20));
insert into @Male_middle_names values 
(1,'Kumar'),(2,'Raj'),(3,'Chandra'),(4,'Dev'),(5,'Mohan'),(6,'Prakash'),(7,'Anand');

declare @Male_last_names table(id int, name varchar(20));
insert into @Male_last_names values
(1,'Sharma'),(2,'Patel'),(3,'Singh'),(4,'Kumar'),(5,'Gupta'),(6,'Agarwal'),
(7,'Reddy'),(8,'Nair'),(9,'Iyer'),(10,'Mehta'),(11,'Joshi'),(12,'Rao'),
(13,'Chopra'),(14,'Bansal'),(15,'Malhotra'),(16,'Sinha'),(17,'Verma'),(18,'Tiwari'),
(19,'Mishra'),(20,'Pandey'),(21,'Shah'),(22,'Kapoor'),(23,'Aggarwal'),(24,'Jain'),(25,'Khanna');


declare @i int = 1;
declare @gender varchar(10);
declare @DOB date;
declare @personal_phone varchar(20);

declare @min_age int;
declare @max_age int;
declare @base_date date;
declare @range int;	
DECLARE @first_name VARCHAR(20);
DECLARE @middle_name VARCHAR(20);
DECLARE @last_name VARCHAR(20);

while @i<=5000

begin
set @gender = case when @i <= 5000*0.65 then 'Female'
else 'Male' end;

if @i <= 5000*0.18
begin
set @min_age = 7;
set @max_age = 12;
end

else if @i<= 5000*(0.18+0.27)
begin
set @min_age = 13;
set @max_age = 14;
end
else if @i<=5000*(0.18+0.27+0.20)
begin
set @min_age = 15;
set @max_age = 17;
end

else 
begin 
set @min_age = 18;
set @max_age = 19
end


set @range = (@max_age-@min_age)*365;
set @base_date = DATEADD(year,-@max_age,cast(getdate() as date));
set @DOB = DATEADD(day,round(rand(@i*1000)*@range,0),@base_date);


set @personal_phone = '9' + RIGHT('000000000'+cast(cast(rand(@i*1000)*1000000000 as int) as varchar),9);


if @gender = 'Female'
begin
set @first_name = (select name from @Female_first_names where id = (@i % 13) + 1);
set @middle_name = (select name from @Female_middle_names where id = (@i % 10) + 1);
set @last_name = (select name from @Female_last_names where id = (@i % 25) + 1);
end
else
begin
set @first_name = (select name from @Male_first_names where id = (@i % 10) + 1);
set @middle_name = (select name from @Male_middle_names where id = (@i % 7) + 1);
set @last_name = (select name from @Male_last_names where id = (@i % 25) + 1);
end

insert into @Students
values(
@i,
@first_name,
@middle_name,
@last_name,
@gender,
@DOB,
@personal_phone,
lower(@first_name) + lower(@middle_name) + lower(@last_name) + cast(@i as varchar) + 
case (@i % 4) 
when 0 then '@gmail.com'
when 1 then '@yahoo.com'
when 2 then '@outlook.com'
else '@hotmail.com'
end
);

set @i = @i+1
end;



--Task 3
with generations as (
select 'Gen Alpha' as generation
union select 'Gen Z'
union select 'Millennials'
union select 'Gen X'
union select 'Other'
),
gender as (
select 'Male' as gender
union
select 'Female'
),
combinations as (
select a.generation,b.gender from generations a
cross join gender b
),
temp as (select case 
when DATEDIFF(year,DOB,getdate()) <= 12 then 'Gen Alpha'
when DATEDIFF(year,DOB,getdate()) between 13 and 26 then 'Gen Z'
when DATEDIFF(year,DOB,getdate()) between 27 and 44 then 'Millennials'
when DATEDIFF(year,DOB,getdate()) between 45 and 60 then 'Gen X'
else 'Other'
end 
as generation,
gender,
count(*) as count
from @Students
group by case 
when DATEDIFF(year,DOB,getdate()) <= 12 then 'Gen Alpha'
when DATEDIFF(year,DOB,getdate()) between 13 and 26 then 'Gen Z'
when DATEDIFF(year,DOB,getdate()) between 27 and 44 then 'Millennials'
when DATEDIFF(year,DOB,getdate()) between 45 and 60 then 'Gen X'
else 'Other' end
,gender),
totalCountPerGeneration as (select generation,SUM(count) as total from temp 
group by generation)


select c.generation,c.gender,
isnull(cast(100.00*t.count/tcpg.total as decimal(5,2)),0.00) as percentage
from combinations c
left join temp t
on c.generation = t.generation 
and c.gender = t.gender
left join totalCountPerGeneration tcpg
on c.generation = tcpg.generation
order by c.generation,c.gender