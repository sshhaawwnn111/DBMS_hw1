select T.team_long_name, round((win_score_diff + lose_score_diff)/(win_count + even_count + lose_count), 2) as avg_win_score
from (select T1.team_long_name, (2*win_count + even_count)/(win_count + even_count + lose_count) as score, win_count, even_count, lose_count, win_score_diff, lose_score_diff
      from (select T.team_long_name, count(T.team_long_name) as even_count
            from (select M.home_team_id as win_team_id
                  from match_info M
                  where M.home_team_score = M.away_team_score and M.season = '2015/2016'
                  union all
                  select M.away_team_id
                  from match_info M
                  where M.away_team_score = M.home_team_score and M.season = '2015/2016') W
            left join team T on W.win_team_id = T.id
            group by T.team_long_name) T1
      
           inner join (select T.team_long_name, count(T.team_long_name) as win_count, sum(score_diff) as win_score_diff
                       from (select M.home_team_id as win_team_id, M.home_team_score - M.away_team_score as score_diff
                             from match_info M
                             where M.home_team_score > M.away_team_score and M.season = '2015/2016'
                             union all
                             select M.away_team_id, M.away_team_score - M.home_team_score as score_diff
                             from match_info M
                             where M.away_team_score > M.home_team_score and M.season = '2015/2016') W
                       left join team T on W.win_team_id = T.id
                       group by T.team_long_name) T2 on T1.team_long_name = T2.team_long_name
          
           inner join (select T.team_long_name, count(T.team_long_name) as lose_count, sum(score_diff) as lose_score_diff
                       from (select M.home_team_id as lose_team_id, M.home_team_score - M.away_team_score as score_diff
                             from match_info M
                             where M.home_team_score < M.away_team_score and M.season = '2015/2016'
                             union all
                             select M.away_team_id, M.away_team_score - M.home_team_score as score_diff
                             from match_info M
                             where M.away_team_score < M.home_team_score and M.season = '2015/2016') W
                       left join team T on W.lose_team_id = T.id
                       group by T.team_long_name) T3 on T2.team_long_name = T3.team_long_name
      order by score desc
      limit 5) T;