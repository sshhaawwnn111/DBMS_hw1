select distinct T.date, cast(S.coronavirus as decimal(38,2)) as coronavirus, T.confirmed_accumulated,T.confirmed_add, T.dead_accumulate, T.dead_add
from search_trend S
inner join (select distinct T.date, T.confirmed as confirmed_accumulated,
                            T.confirmed - lag(T.confirmed, 1, 0) over(order by T.date) as confirmed_add,
                            T.deceased as dead_accumulate,
                            T.deceased - lag(T.deceased, 1, 0) over(order by T.date) as dead_add
            from time T) T on T.date = S.date
where S.coronavirus > (select 2*std(S2.coronavirus) + avg(S2.coronavirus)
                       from search_trend S2
                       where S2.date between '2019-12-25' and '2020-06-29') and T.date = S.date
order by T.date;