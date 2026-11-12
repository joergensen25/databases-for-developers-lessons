create table postnummer12
(
postnr char(4) primary key,
postdistrikt varchar(25)
)

create table person12
(
cpr char(10) primary key,
navn varchar(25),
stilling varchar(25),
loen int not null check(loen > 0),
postnr char(4) not null,
foreign key (postnr) references postnummer12(postnr) 
)

create table firma12
(
firmanr int primary key,
firmanavn varchar(25),
postnr char(4) not null,
foreign key (postnr) references postnummer12(postnr) 
)

create table ansati12
(
cpr char(10),
constraint cprforeign12  foreign key (cpr) references person12(cpr),
firmanr int, 
constraint firmaforeign12 foreign key (firmanr) references firma12(firmanr),
primary key(cpr,firmanr)
)

create table konto12
(
kontonr int primary key,
kontoejer char(10),
foreign key (kontoejer) references person12,
saldo int
)

insert into postnummer12 values('8000','Århus C');
insert into postnummer12 values('8200','Århus N');
insert into postnummer12 values('8210','Århus V');
insert into postnummer12 values('8220','Brabrand');
insert into postnummer12 values('8240','Risskov');
insert into postnummer12 values('8310','Tranbjerg J');
insert into postnummer12 values('8270','Højbjerg');
insert into postnummer12 values('8250','Egå');
insert into person12 values('1212121212','Ib Hansen','systemudvikler',250000,'8000');
insert into person12 values('1313131313','Poul Ibsen','projektleder',500000,'8310');
insert into person12 values('1414141414','Anna Poulsen','IT-chef',870000,'8250');
insert into person12 values('1515151515','Jette Olsen','systemudvikler',200000,'8000');
insert into person12 values('1616161616','Roy Hurtigkoder','programmør',500000,'8210');
insert into firma12 values(1,'Danske Data','8220');
insert into firma12 values(2,'Kommunedata','8000');
insert into firma12 values(3,'LEC','8240');
insert into firma12 values(4,'Dansk Supermarked','8270');
insert into ansati12 values('1212121212',2);
insert into ansati12 values('1313131313',4);
insert into ansati12 values('1414141414',4);
insert into ansati12 values('1616161616',2);
insert into konto12 values(1001,'1414141414',2000);
insert into konto12 values(1002,'1616161616',10000);
insert into konto12 values(1003,'1212121212',100);
insert into konto12 values(1004,'1414141414',12000);


-- Opgave 1:
declare
tal int := 10;
fakultet int := 1;
begin
for i in 1..tal loop
fakultet := fakultet * i;
end loop;
dbms_output.put_line(tal ||' fakultet er lig med ' || fakultet);
end;


-- Opgave 2:
create or replace procedure totalsaldo12
(cpr in char, tsaldo out int)
as
begin
select sum(saldo) into tsaldo from konto12 where kontoejer = cpr;
end;

-- Opgave 2 test:
declare
tsaldo int;
begin
totalsaldo12('1414141414', tsaldo);
dbms_output.put_line('Total saldo er ' || tsaldo);
end;


-- Opgave 3:
create or replace trigger delaccount12
before delete on konto12
for each row
begin
    if :old.saldo <> 0 then
        raise_application_error(-20001, 'Account could not be deleted');
        
    end if;
end;

-- Opgave 3 test:
delete from konto12 where kontonr = 1001;


-- Opgave 4.1:
drop table student12;
drop type gradesArrayType12;

create or replace type gradesArrayType12 is varray(5) of int;

create table student12
(
studentno int,
name varchar(30),
grades gradesArrayType12
)

insert into student12 values (1,'clever boy', gradesArrayType12(11, 13, 9, 10, 13));
insert into student12 values (2,'fool', gradesArrayType12(5, 3, 7, 6, 6));


-- Opgave 4.2:
create or replace procedure studentGradesSum
(numbb in int)
as
begin
select name, sum(grades) from student12 where studentno = numbb
group by name;
end;


-- Opgave 5:
declare
counter int;
totalloen int;
loen int;
cursor mycursor is
select loen from person12;
begin
counter := 0;
totalloen := 0;
for rec in mycursor
loop
    totalloen := totalloen + rec.loen;
end loop;
dbms_output.put_line('Total loen er: ' || totalloen);
end;


