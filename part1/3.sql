select province, city, elementary_school_count
from region R
where R.province != R.city
order by elementary_school_count desc
limit 3;