-- looking at total cases vs total Deaths
-- showing chances of dying at with time

SELECT covid_19_india.Date, sum(covid_19_india.Confirmed) as 'cases',
sum(covid_19_india.Deaths) as 'death',((sum(covid_19_india.Deaths)/sum(covid_19_india.Confirmed))*100) as 'death_rate' 
FROM covid_19_india
GROUP by covid_19_india.Date;

-- total cases vs poplation in 2020 that is 1390000000
SELECT covid_19_india.Date, sum(covid_19_india.Confirmed) as 'cases',
((sum(covid_19_india.Confirmed)/1390000000)*1000000) as 'confirmed_in_million' ,((sum(covid_19_india.Deaths)/sum(covid_19_india.Confirmed))*100) as 'death_rate'
FROM covid_19_india
GROUP by covid_19_india.Date;

-- looking at states with highest infection rate

SELECT max(covid_19_india.Confirmed) as 'max_cases',
((sum(covid_19_india.Confirmed)/1390000000)*1000000) as 'confirmed_in_million' ,((sum(covid_19_india.Deaths)/sum(covid_19_india.Confirmed))*100) as 'death_rate'
FROM covid_19_india
GROUP by covid_19_india.Date;

-- number of states

SELECT count(covid_19_india.Sno),covid_19_india.State
FROM covid_19_india
GROUP by covid_19_india.State;

--updating records

UPDATE covid_19_india
SET State = 'A & N Islands'
WHERE State = 'Andaman and Nicobar Islands';

-- joining statewise population in covid 19 india table 

SELECT covid_19_india.State, state_population.Total_population 
FROM covid_19_india LEFT JOIN state_population on covid_19_india.State = state_population.state_
ORDER by covid_19_india.State;
-- WHERE state_population.Total_population is NULL;

-- looking at state with highest infection rate

SELECT f.states, (f.maximum_confirmed/f.popula)*100 as perce FROM (SELECT covid_19_india.State as states, state_population.Total_population2 as popula, max (covid_19_india.Confirmed) as maximum_confirmed
FROM covid_19_india LEFT JOIN state_population on covid_19_india.State = state_population.state_
GROUP by covid_19_india.State, Total_population2) as f
ORDER by perce DESC;
	
--state positivity rate for MP

SELECT covid_19_india.Date, ((covid_19_india.Confirmed /85358965)*100) as infection_rate
FROM covid_19_india WHERE covid_19_india.State = 'Madhya Pradesh';

--Looking at state with highest total death 

SELECT covid_19_india.State, 
sum (covid_19_india.Deaths) as total_deathcount
FROM covid_19_india LEFT JOIN state_population on covid_19_india.State = state_population.state_
GROUP by covid_19_india.State
ORDER by total_deathcount DESC; 

--Looking at state with highest total deathpercent that is how much population vanished due to covid


SELECT covid_19_india.State, 
((sum (covid_19_india.Deaths))/state_population.Total_population2)*100 as total_deathrate
FROM covid_19_india LEFT JOIN state_population on covid_19_india.State = state_population.state_
GROUP by covid_19_india.State, state_population.Total_population2
ORDER by total_deathrate DESC;
   
-- how confirmed cases, deaths and death percent goes with time in country

SELECT covid_19_india.Date, sum(covid_19_india.Confirmed), sum(covid_19_india.Deaths), 
(sum(covid_19_india.Deaths)/sum(covid_19_india.Confirmed))*100 as death_percentage
FROM covid_19_india
GROUP by covid_19_india.Date
ORDER by 1;


-- creating view to data for later visualizations


CREATE VIEW case_and_deaths_with_time as
SELECT covid_19_india.Date, sum(covid_19_india.Confirmed), sum(covid_19_india.Deaths), 
(sum(covid_19_india.Deaths)/sum(covid_19_india.Confirmed))*100 as death_percentage
FROM covid_19_india
GROUP by covid_19_india.Date
ORDER by 1;

CREATE VIEW state_infection_rate as
SELECT f.states, (f.maximum_confirmed/f.popula)*100 as perce FROM (SELECT covid_19_india.State as states, state_population.Total_population2 as popula, max (covid_19_india.Confirmed) as maximum_confirmed
FROM covid_19_india LEFT JOIN state_population on covid_19_india.State = state_population.state_
GROUP by covid_19_india.State, Total_population2) as f
ORDER by perce DESC;
