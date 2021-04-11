select distinct T.date, round(S.coronavirus, 2) as coronavirus, T.confirmed as confirmed_accumulated,
                T.confirmed - lag(T.confirmed, 1, 0) over(order by T.date) as confirmed_add,
                T.deceased as dead_accumulate,
                T.deceased - lag(T.deceased, 1, 0) over(order by T.date) as dead_add
from time T, search_trend S
where S.coronavirus > (select 2*std(S2.coronavirus) + avg(S2.coronavirus)
                       from search_trend S2
                       where S2.date between '2019-12-25' and '2020-06-29') and T.date = S.date
order by T.date;