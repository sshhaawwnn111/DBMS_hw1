select 2*std(R.coronavirus) + avg(R.coronavirus)
from search_trend R;


select T.date, S.coronavirus, SUM(T2.confirmed) as confirmed_accumulated
from time T
inner join time T2 on T.date >= T2.date
inner join search_trend S on T.date = S.date
where S.coronavirus > (select 2*std(S2.coronavirus) + avg(S2.coronavirus)
                       from search_trend S2
                       where S2.date between '2019-12-25' and '2020-06-29')
group by T.date
order by T.date;

select avg(S2.coronavirus)
from search_trend S2
where S2.date between '2019-12-25' and '2020-06-29';

select T.date, lag(T.date,1) over(order by T.date) as confirmed_add
from time T

order by T.date;
