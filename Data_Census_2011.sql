-- query 2 and 3 gives us the dataset1 and dataset2.
SELECT * FROM portfolio.dataset1;
SELECT * FROM portfolio.dataset2;

-- number of rows in our data sets
SELECT COUNT(*) FROM portfolio.dataset1;
SELECT COUNT(*) FROM portfolio.dataset2;

-- dataset for only jharkhand and bihar
SELECT * FROM portfolio.dataset1 WHERE State IN ('Jharkhand' , 'Bihar');

-- population of India
SELECT sum(Population) as Total_Population
from portfolio.dataset2;

-- average growth for states
select state, avg(growth) as Average_Growth from portfolio.dataset1
group by state;

-- average sex ratio (Also we use round function to make it a whole number)
select state, round(avg(Sex_Ratio), 0) as Sex_Ratio_Growth from portfolio.dataset1
group by state 
order by Sex_Ratio_Growth desc;

-- average literacy rate
select state, round(avg(Literacy), 0) as Avg_Literacy from portfolio.dataset1
group by state
Having round(avg(Literacy), 0) > 90
order by Avg_Literacy desc;

-- top 3 states showing highest growth ratio
select state, avg(growth) as Average_Growth from portfolio.dataset1
group by state order by Average_Growth desc 
Limit 3;

-- bottom 3 states showing least growth ratio
select state, avg(growth) as Average_Growth from portfolio.dataset1
group by state order by Average_Growth asc
Limit 3;

-- displaying top and bottom 3 states in literacy rate
Create table Top_States
(state varchar(255), topstates float);
insert into Top_States 
select state, round(avg(literacy),0) as Average_Literacy from portfolio.dataset1
group by state order by Average_Literacy desc;

select * from Top_States Limit 3;

Create table Bottom_States (state varchar(1000), bottomstates float); 
insert into Bottom_States select state, round(avg(literacy),0) as Average_Literacy from portfolio.dataset1 group by state order by Average_Literacy desc; 
select * from Bottom_States;

-- States starting with letter a or b
select Distinct state from portfolio.dataset1
where state Like 'a%'or state Like 'b%' order by state asc;

-- states starting with letter a and ending with letter m
select Distinct state from portfolio.dataset1
where state Like 'a%' and state Like '%m' order by state asc;

-- joining both the tables
select d1.district, d1.state, d1.sex_ratio, d2.Population
from portfolio.dataset1 as d1
inner join portfolio.dataset2 as d2
on d1.District = d2.District;

-- finding total number of males. Derived formula is population/Sex_ratio+1 and for females population*Sex_ratio/(Sex_ratio+1)

select c.district, c.state, (c.population/(c.sex_ratio+1)) as Males, round((c.population*c.sex_ratio)/(c.sex_ratio+1),0) as Females from
(select d1.district, d1.state, d1.sex_ratio, d2.Population
from portfolio.dataset1 as d1
inner join portfolio.dataset2 as d2
on d1.District = d2.District) as c;









 





















