with cold_match(match_id) as
    (select M.id
     from match_info M
     where M.away_team_score - M.home_team_score >= 5 and 
           ((M.B365A > M.B365D and M.B365A > M.B365H) or (M.WHA > M.WHD and M.WHA > M.WHH) or (M.SJA > M.SJD and M.SJA > M.SJH))
     union
     select M.id
     from match_info M
     where M.home_team_score - M.away_team_score >= 5 and 
           ((M.B365H > M.B365D and M.B365H > M.B365A) or (M.WHH > M.WHD and M.WHH > M.WHA) or (M.SJH > M.SJD and M.SJH > M.SJA)))
select A.match_id, round(A.home_team_avg_age, 2) as home_player_avg_age, round(A.away_team_avg_age, 2) as away_player_avg_age, round(R.home_avg_rating, 2) as home_player_avg_rating, round(R.away_avg_rating, 2) as away_player_avg_rating
from (select M.match_id, (ifnull(timestampdiff(year,P1.birthday, M.date), 0) + 
                         ifnull(timestampdiff(year, P2.birthday, M.date), 0) + 
                         ifnull(timestampdiff(year, P3.birthday, M.date), 0) + 
                         ifnull(timestampdiff(year, P4.birthday, M.date), 0) + 
                         ifnull(timestampdiff(year, P5.birthday, M.date), 0) + 
                         ifnull(timestampdiff(year, P6.birthday, M.date), 0) + 
                         ifnull(timestampdiff(year, P7.birthday, M.date), 0) + 
                         ifnull(timestampdiff(year, P8.birthday, M.date), 0) + 
                         ifnull(timestampdiff(year, P9.birthday, M.date), 0) + 
                         ifnull(timestampdiff(year, P10.birthday, M.date), 0) +
                         ifnull(timestampdiff(year, P11.birthday, M.date), 0))/
                        ((if(P1.birthday, 1, 0)) +
                         (if(P2.birthday, 1, 0)) +
                         (if(P3.birthday, 1, 0)) +
                         (if(P4.birthday, 1, 0)) +
                         (if(P5.birthday, 1, 0)) +
                         (if(P6.birthday, 1, 0)) +
                         (if(P7.birthday, 1, 0)) +
                         (if(P8.birthday, 1, 0)) +
                         (if(P9.birthday, 1, 0)) +
                         (if(P10.birthday, 1, 0)) +
                         (if(P11.birthday, 1, 0))) as home_team_avg_age,
      
                         (ifnull(timestampdiff(year,P12.birthday, M.date), 0) + 
                         ifnull(timestampdiff(year, P13.birthday, M.date), 0) + 
                         ifnull(timestampdiff(year, P14.birthday, M.date), 0) + 
                         ifnull(timestampdiff(year, P15.birthday, M.date), 0) + 
                         ifnull(timestampdiff(year, P16.birthday, M.date), 0) + 
                         ifnull(timestampdiff(year, P17.birthday, M.date), 0) + 
                         ifnull(timestampdiff(year, P18.birthday, M.date), 0) + 
                         ifnull(timestampdiff(year, P19.birthday, M.date), 0) + 
                         ifnull(timestampdiff(year, P20.birthday, M.date), 0) + 
                         ifnull(timestampdiff(year, P21.birthday, M.date), 0) +
                         ifnull(timestampdiff(year, P22.birthday, M.date), 0))/
                        ((if(P12.birthday, 1, 0)) +
                         (if(P13.birthday, 1, 0)) +
                         (if(P14.birthday, 1, 0)) +
                         (if(P15.birthday, 1, 0)) +
                         (if(P16.birthday, 1, 0)) +
                         (if(P17.birthday, 1, 0)) +
                         (if(P18.birthday, 1, 0)) +
                         (if(P19.birthday, 1, 0)) +
                         (if(P20.birthday, 1, 0)) +
                         (if(P21.birthday, 1, 0)) +
                         (if(P22.birthday, 1, 0))) as away_team_avg_age
      from (select M.id as match_id, M.home_player_1, M.home_player_2, M.home_player_3, M.home_player_4, M.home_player_5, M.home_player_6, M.home_player_7, M.home_player_8, M.home_player_9, M.home_player_10, M.home_player_11,
                                     M.away_player_1, M.away_player_2, M.away_player_3, M.away_player_4, M.away_player_5, M.away_player_6, M.away_player_7, M.away_player_8, M.away_player_9, M.away_player_10, M.away_player_11,
                                     M.date
            from match_info M
            where M.away_team_score - M.home_team_score >= 5 and 
                  ((M.B365A > M.B365D and M.B365A > M.B365H) or (M.WHA > M.WHD and M.WHA > M.WHH) or (M.SJA > M.SJD and M.SJA > M.SJH))
            union
            select M.id as match_id, M.home_player_1, M.home_player_2, M.home_player_3, M.home_player_4, M.home_player_5, M.home_player_6, M.home_player_7, M.home_player_8, M.home_player_9, M.home_player_10, M.home_player_11,
                                     M.away_player_1, M.away_player_2, M.away_player_3, M.away_player_4, M.away_player_5, M.away_player_6, M.away_player_7, M.away_player_8, M.away_player_9, M.away_player_10, M.away_player_11,
                                     M.date
            from match_info M
            where M.home_team_score - M.away_team_score >= 5 and 
                  ((M.B365H > M.B365D and M.B365H > M.B365A) or (M.WHH > M.WHD and M.WHH > M.WHA) or (M.SJH > M.SJD and M.SJH > M.SJA))) M
      left join (select P.player_api_id, P.birthday from player P) P1 on P1.player_api_id = M.home_player_1
      left join (select P.player_api_id, P.birthday from player P) P2 on P2.player_api_id = M.home_player_2
      left join (select P.player_api_id, P.birthday from player P) P3 on P3.player_api_id = M.home_player_3
      left join (select P.player_api_id, P.birthday from player P) P4 on P4.player_api_id = M.home_player_4
      left join (select P.player_api_id, P.birthday from player P) P5 on P5.player_api_id = M.home_player_5
      left join (select P.player_api_id, P.birthday from player P) P6 on P6.player_api_id = M.home_player_6
      left join (select P.player_api_id, P.birthday from player P) P7 on P7.player_api_id = M.home_player_7
      left join (select P.player_api_id, P.birthday from player P) P8 on P8.player_api_id = M.home_player_8
      left join (select P.player_api_id, P.birthday from player P) P9 on P9.player_api_id = M.home_player_9
      left join (select P.player_api_id, P.birthday from player P) P10 on P10.player_api_id = M.home_player_10
      left join (select P.player_api_id, P.birthday from player P) P11 on P11.player_api_id = M.home_player_11
      left join (select P.player_api_id, P.birthday from player P) P12 on P12.player_api_id = M.away_player_1
      left join (select P.player_api_id, P.birthday from player P) P13 on P13.player_api_id = M.away_player_2
      left join (select P.player_api_id, P.birthday from player P) P14 on P14.player_api_id = M.away_player_3
      left join (select P.player_api_id, P.birthday from player P) P15 on P15.player_api_id = M.away_player_4
      left join (select P.player_api_id, P.birthday from player P) P16 on P16.player_api_id = M.away_player_5
      left join (select P.player_api_id, P.birthday from player P) P17 on P17.player_api_id = M.away_player_6
      left join (select P.player_api_id, P.birthday from player P) P18 on P18.player_api_id = M.away_player_7
      left join (select P.player_api_id, P.birthday from player P) P19 on P19.player_api_id = M.away_player_8
      left join (select P.player_api_id, P.birthday from player P) P20 on P20.player_api_id = M.away_player_9
      left join (select P.player_api_id, P.birthday from player P) P21 on P21.player_api_id = M.away_player_10
      left join (select P.player_api_id, P.birthday from player P) P22 on P22.player_api_id = M.away_player_11) A
left join (select P1.id, (ifnull(P1.avg, 0) + ifnull(P2.avg, 0) + ifnull(P3.avg, 0) + ifnull(P4.avg, 0) + ifnull(P5.avg, 0) + ifnull(P6.avg, 0) + ifnull(P7.avg, 0) + ifnull(P8.avg, 0) + ifnull(P9.avg, 0) + ifnull(P10.avg, 0) + ifnull(P11.avg, 0))/(if(P1.avg, 1, 0) + if(P2.avg, 1, 0) + if(P3.avg, 1, 0) + if(P4.avg, 1, 0) + if(P5.avg, 1, 0) + if(P6.avg, 1, 0) + if(P7.avg, 1, 0) + if(P8.avg, 1, 0) + if(P9.avg, 1, 0) + if(P10.avg, 1, 0) + if(P11.avg, 1, 0)) as home_avg_rating, 
                         (ifnull(P12.avg, 0) + ifnull(P13.avg, 0) + ifnull(P14.avg, 0) + ifnull(P15.avg, 0) + ifnull(P16.avg, 0) + ifnull(P17.avg, 0) + ifnull(P18.avg, 0) + ifnull(P19.avg, 0) + ifnull(P20.avg, 0) + ifnull(P21.avg, 0) + ifnull(P22.avg, 0))/(if(P12.avg, 1, 0) + if(P13.avg, 1, 0) + if(P14.avg, 1, 0) + if(P15.avg, 1, 0) + if(P16.avg, 1, 0) + if(P17.avg, 1, 0) + if(P18.avg, 1, 0) + if(P19.avg, 1, 0) + if(P20.avg, 1, 0) + if(P21.avg, 1, 0) + if(P22.avg, 1, 0)) as away_avg_rating
           from (select M.id, avg(P.overall_rating) as avg from player_attributes P, match_info M, cold_match C where timestampdiff(month,P.date, M.date) < 6 and timestampdiff(month,P.date, M.date) >= 0 and M.home_player_1 = P.player_api_id and M.id = C.match_id group by M.id) P1
           left join (select M.id, avg(P.overall_rating) as avg from player_attributes P, match_info M, cold_match C where timestampdiff(month,P.date, M.date) < 6 and timestampdiff(month,P.date, M.date) >= 0 and M.home_player_2 = P.player_api_id and M.id = C.match_id group by M.id) P2 on P1.id = P2.id
           left join (select M.id, avg(P.overall_rating) as avg from player_attributes P, match_info M, cold_match C where timestampdiff(month,P.date, M.date) < 6 and timestampdiff(month,P.date, M.date) >= 0 and M.home_player_3 = P.player_api_id and M.id = C.match_id group by M.id) P3 on P1.id = P3.id
           left join (select M.id, avg(P.overall_rating) as avg from player_attributes P, match_info M, cold_match C where timestampdiff(month,P.date, M.date) < 6 and timestampdiff(month,P.date, M.date) >= 0 and M.home_player_4 = P.player_api_id and M.id = C.match_id group by M.id) P4 on P1.id = P4.id
           left join (select M.id, avg(P.overall_rating) as avg from player_attributes P, match_info M, cold_match C where timestampdiff(month,P.date, M.date) < 6 and timestampdiff(month,P.date, M.date) >= 0 and M.home_player_5 = P.player_api_id and M.id = C.match_id group by M.id) P5 on P1.id = P5.id
           left join (select M.id, avg(P.overall_rating) as avg from player_attributes P, match_info M, cold_match C where timestampdiff(month,P.date, M.date) < 6 and timestampdiff(month,P.date, M.date) >= 0 and M.home_player_6 = P.player_api_id and M.id = C.match_id group by M.id) P6 on P1.id = P6.id
           left join (select M.id, avg(P.overall_rating) as avg from player_attributes P, match_info M, cold_match C where timestampdiff(month,P.date, M.date) < 6 and timestampdiff(month,P.date, M.date) >= 0 and M.home_player_7 = P.player_api_id and M.id = C.match_id group by M.id) P7 on P1.id = P7.id
           left join (select M.id, avg(P.overall_rating) as avg from player_attributes P, match_info M, cold_match C where timestampdiff(month,P.date, M.date) < 6 and timestampdiff(month,P.date, M.date) >= 0 and M.home_player_8 = P.player_api_id and M.id = C.match_id group by M.id) P8 on P1.id = P8.id
           left join (select M.id, avg(P.overall_rating) as avg from player_attributes P, match_info M, cold_match C where timestampdiff(month,P.date, M.date) < 6 and timestampdiff(month,P.date, M.date) >= 0 and M.home_player_9 = P.player_api_id and M.id = C.match_id group by M.id) P9 on P1.id = P9.id
           left join (select M.id, avg(P.overall_rating) as avg from player_attributes P, match_info M, cold_match C where timestampdiff(month,P.date, M.date) < 6 and timestampdiff(month,P.date, M.date) >= 0 and M.home_player_10 = P.player_api_id and M.id = C.match_id group by M.id) P10 on P1.id = P10.id
           left join (select M.id, avg(P.overall_rating) as avg from player_attributes P, match_info M, cold_match C where timestampdiff(month,P.date, M.date) < 6 and timestampdiff(month,P.date, M.date) >= 0 and M.home_player_11 = P.player_api_id and M.id = C.match_id group by M.id) P11 on P1.id = P11.id
           left join (select M.id, avg(P.overall_rating) as avg from player_attributes P, match_info M, cold_match C where timestampdiff(month,P.date, M.date) < 6 and timestampdiff(month,P.date, M.date) >= 0 and M.away_player_1 = P.player_api_id and M.id = C.match_id group by M.id) P12 on P1.id = P12.id
           left join (select M.id, avg(P.overall_rating) as avg from player_attributes P, match_info M, cold_match C where timestampdiff(month,P.date, M.date) < 6 and timestampdiff(month,P.date, M.date) >= 0 and M.away_player_2 = P.player_api_id and M.id = C.match_id group by M.id) P13 on P1.id = P13.id
           left join (select M.id, avg(P.overall_rating) as avg from player_attributes P, match_info M, cold_match C where timestampdiff(month,P.date, M.date) < 6 and timestampdiff(month,P.date, M.date) >= 0 and M.away_player_3 = P.player_api_id and M.id = C.match_id group by M.id) P14 on P1.id = P14.id
           left join (select M.id, avg(P.overall_rating) as avg from player_attributes P, match_info M, cold_match C where timestampdiff(month,P.date, M.date) < 6 and timestampdiff(month,P.date, M.date) >= 0 and M.away_player_4 = P.player_api_id and M.id = C.match_id group by M.id) P15 on P1.id = P15.id
           left join (select M.id, avg(P.overall_rating) as avg from player_attributes P, match_info M, cold_match C where timestampdiff(month,P.date, M.date) < 6 and timestampdiff(month,P.date, M.date) >= 0 and M.away_player_5 = P.player_api_id and M.id = C.match_id group by M.id) P16 on P1.id = P16.id
           left join (select M.id, avg(P.overall_rating) as avg from player_attributes P, match_info M, cold_match C where timestampdiff(month,P.date, M.date) < 6 and timestampdiff(month,P.date, M.date) >= 0 and M.away_player_6 = P.player_api_id and M.id = C.match_id group by M.id) P17 on P1.id = P17.id
           left join (select M.id, avg(P.overall_rating) as avg from player_attributes P, match_info M, cold_match C where timestampdiff(month,P.date, M.date) < 6 and timestampdiff(month,P.date, M.date) >= 0 and M.away_player_7 = P.player_api_id and M.id = C.match_id group by M.id) P18 on P1.id = P18.id
           left join (select M.id, avg(P.overall_rating) as avg from player_attributes P, match_info M, cold_match C where timestampdiff(month,P.date, M.date) < 6 and timestampdiff(month,P.date, M.date) >= 0 and M.away_player_8 = P.player_api_id and M.id = C.match_id group by M.id) P19 on P1.id = P19.id
           left join (select M.id, avg(P.overall_rating) as avg from player_attributes P, match_info M, cold_match C where timestampdiff(month,P.date, M.date) < 6 and timestampdiff(month,P.date, M.date) >= 0 and M.away_player_9 = P.player_api_id and M.id = C.match_id group by M.id) P20 on P1.id = P20.id
           left join (select M.id, avg(P.overall_rating) as avg from player_attributes P, match_info M, cold_match C where timestampdiff(month,P.date, M.date) < 6 and timestampdiff(month,P.date, M.date) >= 0 and M.away_player_10 = P.player_api_id and M.id = C.match_id group by M.id) P21 on P1.id = P21.id
           left join (select M.id, avg(P.overall_rating) as avg from player_attributes P, match_info M, cold_match C where timestampdiff(month,P.date, M.date) < 6 and timestampdiff(month,P.date, M.date) >= 0 and M.away_player_11 = P.player_api_id and M.id = C.match_id group by M.id) P22 on P1.id = P22.id) R
on A.match_id = R.id
order by A.match_id;