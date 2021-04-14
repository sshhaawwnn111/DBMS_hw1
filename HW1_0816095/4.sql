select R.province, count(W.avg_relative_humidity) as cnt
from region R, weather W
where W.date between '2016-05-01' and '2016-05-31' and 
      W.avg_relative_humidity > 70 and
      R.code = W.code
group by R.province
order by count(W.avg_relative_humidity) desc
limit 3;