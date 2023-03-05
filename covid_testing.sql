SELECT * FROM StatewiseTestingDetails
WHERE Positive is NULL AND Negative is NULL
order by StatewiseTestingDetails.Date;

-- positive and negative cases detail is not present but on covid_19_india table we have seen Confirmed cases
-- that is Positive with respect to time and state 

-- here we how much testing is done during covid time

SELECT StatewiseTestingDetails.Date, sum(TotalSamples)
FROM StatewiseTestingDetails
GROUP by StatewiseTestingDetails.Date
order by 1;

-- total sampling, confirmed and positive rate(if hypothetically test result comes on same day) cases during covid time

select covid_19_india.Date, sum(covid_19_india.Confirmed), sum(StatewiseTestingDetails.TotalSamples), 
(sum(covid_19_india.Confirmed)/sum(StatewiseTestingDetails.TotalSamples))*100 as positive_rate 
FROM covid_19_india LEFT JOIN StatewiseTestingDetails on covid_19_india.Date = StatewiseTestingDetails.Date
GROUP by covid_19_india.Date;

-- positivity rate if by examine we found that on a average test results comes in 3 days 

select covid_19_india.Date, sum(covid_19_india.Confirmed), sum(StatewiseTestingDetails.TotalSamples),
(sum(covid_19_india.Confirmed)/lag(sum(StatewiseTestingDetails.TotalSamples),3)OVER(order by covid_19_india.Date))*100 as positive_rate 
FROM covid_19_india LEFT JOIN StatewiseTestingDetails on covid_19_india.Date = StatewiseTestingDetails.Date
GROUP by covid_19_india.Date;

-- state with maximum sampling 

SELECT StatewiseTestingDetails.State, StatewiseTestingDetails.TotalSamples, StatewiseTestingDetails.Date
FROM StatewiseTestingDetails
WHERE StatewiseTestingDetails.TotalSamples in (SELECT max(TotalSamples)
FROM StatewiseTestingDetails
GROUP by StatewiseTestingDetails.State)
ORDER by StatewiseTestingDetails.TotalSamples DESC;



-- creating views for visualisation


create VIEW positivity_rate as
select covid_19_india.Date, sum(covid_19_india.Confirmed) as confirmed_cases, sum(StatewiseTestingDetails.TotalSamples) as samples_collected,
(sum(covid_19_india.Confirmed)/lag(sum(StatewiseTestingDetails.TotalSamples),3)OVER(order by covid_19_india.Date))*100 as positive_rate 
FROM covid_19_india LEFT JOIN StatewiseTestingDetails on covid_19_india.Date = StatewiseTestingDetails.Date
GROUP by covid_19_india.Date;
