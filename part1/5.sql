select distinct T.province, R2.date, R1.max_confirmed_add
from time_province T
inner join (select R.province, max(R.confirmed_add) as max_confirmed_add
            from (select R.province, T.confirmed - lag(T.confirmed, 8, 0) over(order by T.date) as confirmed_add
                  from region R, time_province T
                  where R.elderly_population_ratio > (select avg(R1.elderly_population_ratio)from region R1 where R1.province = R1.city) and T.province = R.city) R
            group by R.province) R1 on T.province = R1.province
inner join (select R.province, T.confirmed - lag(T.confirmed, 8, 0) over(order by T.date) as confirmed_add, T.date
            from region R, time_province T
            where R.elderly_population_ratio > (select avg(R1.elderly_population_ratio)from region R1 where R1.province = R1.city) and T.province = R.city) R2
            on R2.province = R1.province and R1.max_confirmed_add = R2.confirmed_add
order by R2.date;