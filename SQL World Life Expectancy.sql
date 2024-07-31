select*
from world_life_expectancy;

select country, year, concat(country, year)
from world_life_expectancy;

select country, year, concat(country, year), count(concat(country, year))
from world_life_expectancy
group by country, year, concat(country, year)
having count(concat(country,year)) > 1;

select Row_ID, concat(country, year),
ROW_NUMBER() over(Partition by concat(country, year) order by concat(country, year)) as row_num
from world_life_expectancy;

select*
from(
	select Row_ID, concat(country, year),
	ROW_NUMBER() over(Partition by concat(country, year) order by concat(country, year)) as row_num
	from world_life_expectancy
    ) as row_table
where row_num > 1;

delete from world_life_expectancy
where row_id in (
	select row_id 
from(
	select Row_ID, concat(country, year),
	ROW_NUMBER() over(Partition by concat(country, year) order by concat(country, year)) as row_num
	from world_life_expectancy
    ) as row_table
where row_num > 1
);

select*
from world_life_expectancy
where status = '';

select distinct(status)
from world_life_expectancy
where status <> '';

Select distinct(country)
from world_life_expectancy
where status = 'developing';

update world_life_expectancy
set status = 'developing'
where country in(select distinct(country)
from world_life_expectancy
where status = 'developing');

update world_life_expectancy t1
join world_life_expectancy t2
	on t1.country = t2.country
set t1.status = 'developing'
where t1.status = ''
and t2.status <> ''
and t2.status = 'developing';

select*
from world_life_expectancy
where status = '';

update world_life_expectancy t1
join world_life_expectancy t2
	on t1.country = t2.country
set t1.status = 'developed'
where t1.status = ''
and t2.status <> ''
and t2.status = 'developed';

select*
from world_life_expectancy
where status = '';

select*
from world_life_expectancy
where `life expectancy` = '';

select country, year, `life expectancy`
from world_life_expectancy
where `life expectancy` = '';

select t1.country, t1.year, t1.`life expectancy`,
t2.country, t2.year, t2.`life expectancy`,
t3.country, t3.year, t3.`life expectancy`,
round((t2.`life expectancy` + t3.`life expectancy`)/2,1)
from world_life_expectancy t1
join world_life_expectancy t2
	on t1.country = t2.country
    and t1.year = t2.year - 1
join world_life_expectancy t3
	on t1.country = t3.country
    and t1.year = t3.year + 1
where t1.`life expectancy` = '';

update world_life_expectancy t1
join world_life_expectancy t2
	on t1.country = t2.country
    and t1.year = t2.year - 1
join world_life_expectancy t3
	on t1.country = t3.country
    and t1.year = t3.year + 1
set t1.`life expectancy` = round((t2.`life expectancy` + t3.`life expectancy`)/2,1);

select*
from world_life_expectancy
where `life expectancy` = '';

select*
from world_life_expectancy;

select country, min(`life expectancy`), max(`life expectancy`)
from world_life_expectancy
group by country
order by country desc;

select country, min(`life expectancy`), max(`life expectancy`)
from world_life_expectancy
group by country
having min(`life expectancy`) <> 0
and max(`life expectancy`) <> 0
order by country desc;

select country, 
min(`life expectancy`), 
max(`life expectancy`),
round(max(`life expectancy`) - min(`life expectancy`),1) as Life_Expectancy_Increase
from world_life_expectancy
group by country
having min(`life expectancy`) <> 0
and max(`life expectancy`) <> 0
order by Life_Expectancy_Increase desc;

select country, 
min(`life expectancy`), 
max(`life expectancy`),
round(max(`life expectancy`) - min(`life expectancy`),1) as Life_Expectancy_Increase
from world_life_expectancy
group by country
having min(`life expectancy`) <> 0
and max(`life expectancy`) <> 0
order by Life_Expectancy_Increase asc;

select*
from world_life_expectancy;

select year, round(avg(`life expectancy`),1)
from world_life_expectancy
group by year
having min(`life expectancy`) <> 0
and max(`life expectancy`) <> 0
order by year;

select*
from world_life_expectancy;

select country, round(avg(`life expectancy`),1) as Life_Exp, round(avg(GDP),1) as GDP
from world_life_expectancy
group by country
having life_exp > 0
and GDP > 0
order by life_exp asc;

select
sum(case 
	when GDP >= 1500 then 1
    else 0
end) as high_GDP_Count
from world_life_expectancy;

select
sum(case when GDP >= 1500 then 1 else 0 end) as high_GDP_Count,
round(avg(case when GDP >= 1500 then `life expectancy` else null end),1) as high_GDP_Life_Expectancy,
sum(case when GDP <= 1500 then 1 else 0 end) as low_GDP_Count,
round(avg(case when GDP <= 1500 then `life expectancy` else null end),1) as low_GDP_Life_Expectancy
from world_life_expectancy;

select* 
from world_life_expectancy;

select status, round(avg(`life expectancy`),1)
from world_life_expectancy;

select status, count(distinct country), round(avg(`life expectancy`),1)
from world_life_expectancy
group by status;

select country, round(avg(`life expectancy`),1) as life_exp_avg, round(avg(bmi),1) as BMI_AVG
from world_life_expectancy
group by country
having life_exp_avg > 1
and BMI_AVG > 1
order by BMI_AVG desc;

select country,
year,
`life expectancy`,
`adult mortality`,
sum(`adult mortality`) over(partition by country order by year) as rolling_total
from world_life_expectancy
where country like '%United%States%';


