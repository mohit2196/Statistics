-- Total individual vaccinated with time 

SELECT UpdatedOn, TotalIndividualsVaccinated FROM covid_vaccine_statewise
WHERE covid_vaccine_statewise.UpdatedOn like '%/%/2021' and covid_vaccine_statewise.State = 'India';

-- jan. doses administered (similarly we can check for other months)

SELECT sum(TotalDosesAdministered) as doses, covid_vaccine_statewise.State
FROM covid_vaccine_statewise
WHERE(covid_vaccine_statewise.UpdatedOn) like '%/01/2021'
GROUP by covid_vaccine_statewise.State
ORDER by doses DESC;

-- statewise percentage of population vaccinated 

SELECT covid_vaccine_statewise.State, UpdatedOn, TotalIndividualsVaccinated, state_population.Total_population2,
(TotalIndividualsVaccinated/state_population.Total_population2)*100 as Percent_population_vaccinated
FROM covid_vaccine_statewise JOIN state_population on covid_vaccine_statewise.State = state_population.state_
WHERE covid_vaccine_statewise.UpdatedOn like '%/%/2021' AND State != 'India';

-- we have observed that last data of vaccination collected on 24 june 2021 that is 24/06/2021 and by filtering we can find out
-- Total percentage of population of individual state vaccinated

SELECT covid_vaccine_statewise.State, UpdatedOn, TotalIndividualsVaccinated, state_population.Total_population2,
(TotalIndividualsVaccinated/state_population.Total_population2)*100 as Percent_population_vaccinated
FROM covid_vaccine_statewise JOIN state_population on covid_vaccine_statewise.State = state_population.state_
WHERE covid_vaccine_statewise.UpdatedOn like '24/06/2021' AND State != 'India'
ORDER by Percent_population_vaccinated DESC;


-- creating view for visualisation

CREATE VIEW state_population_vaccinated as
SELECT covid_vaccine_statewise.State, UpdatedOn, TotalIndividualsVaccinated, state_population.Total_population2,
(TotalIndividualsVaccinated/state_population.Total_population2)*100 as Percent_population_vaccinated
FROM covid_vaccine_statewise JOIN state_population on covid_vaccine_statewise.State = state_population.state_
WHERE covid_vaccine_statewise.UpdatedOn like '%/%/2021' AND State != 'India';
 