select distinct infection_case
from patient_info P
where P.province = "Seoul" and 
      P.city = "Gangnam-gu" and 
      P.age < 30 and 
      P.sex = "male"
order by infection_case;