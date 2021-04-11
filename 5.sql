select R.province, T.date
from region R, time_province T
where R.elderly_population_ratio > (select avg(R1.elderly_population_ratio)
                                     from region R1
                                     where R1.province = R1.city)
order by T.confirmed
limit 1;