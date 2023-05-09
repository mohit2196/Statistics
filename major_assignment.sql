create table `major_assignment`.station (ID int not null primary key, city varchar(20), state varchar(20), lat_n float, long_w float);
describe station
insert into station values
(13,'phoenix','az',33,112),
(44,'denever','co',40,105),
(66,'caribou','me',47,68)
select * from station

select * from station where lat_n > 39.7

create table stats (ID int, month int, temp_f float, rain_i float)
describe stats
insert into stats values
(13,1,57.4,0.31),
(13,7,91.7,5.15),
(44,1,27.3,0.18),
(44,7,74.8,2.11),
(66,1,6.7,2.1),
(66,7,65.8,4.52)
select * from stats

select city, month, temp_f from stats inner join station on stats.ID = station.ID

select city, month, rain_i from stats inner join station on stats.ID = station.ID order by 2,3 desc

select city, lat_n, temp_f from stats inner join station on stats.ID = station.ID where month = 7 order by temp_f

select city, max(temp_f), min(temp_f), round(avg(rain_i),2) avg_raifall from stats inner join station on stats.ID = station.ID group by city 

select city, month, (temp_f-32)*5/9 temp_c, rain_i*2.54 rain_cm from stats inner join station on stats.ID = station.ID

update stats
set rain_i = rain_i + 0.01

select * from stats

update stats
set temp_f = 74.9 where ID = 44 and month = 7





