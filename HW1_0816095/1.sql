select count(cold) as cnt
from search_trend S
where S.cold > 0.2;