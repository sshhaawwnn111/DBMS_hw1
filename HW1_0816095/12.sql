select W.team_id, ifnull(cast(W.win_rate * E.B365_win_bet - W.lose_rate - W.even_rate as decimal(38,4)), 'NO DATA') as B365_win_exp, ifnull(cast(W.win_rate * E.WH_win_bet - W.lose_rate - W.even_rate as decimal(38,4)), 'NO DATA') as WH_win_exp, ifnull(cast(W.win_rate * E.SJ_win_bet - W.lose_rate - W.even_rate as decimal(38,4)), 'NO DATA') as SJ_win_exp,
                  ifnull(cast(W.lose_rate * E.B365_lose_bet - W.win_rate - W.even_rate as decimal(38,4)), 'NO DATA') as B365_lose_exp, ifnull(cast(W.lose_rate * E.WH_lose_bet - W.win_rate - W.even_rate as decimal(38,4)), 'NO DATA') as WH_lose_exp, ifnull(cast(W.lose_rate * E.SJ_lose_bet - W.win_rate - W.even_rate as decimal(38,4)), 'NO DATA') as SJ_lose_exp,
                  ifnull(cast(W.even_rate * E.B365_even_bet - W.win_rate - W.lose_rate as decimal(38,4)), 'NO DATA') as B365_even_exp, ifnull(cast(W.even_rate * E.WH_even_bet - W.win_rate - W.lose_rate as decimal(38,4)), 'NO DATA') as WH_even_exp, ifnull(cast(W.even_rate * E.SJ_even_bet - W.win_rate - W.lose_rate as decimal(38,4)), 'NO DATA') as SJ_even_exp
from (select W.win_team_id as team_id, ifnull(W.win_count, 0)/(ifnull(W.win_count, 0) + ifnull(E.even_count, 0) + ifnull(L.lose_count, 0)) as win_rate,
                                       ifnull(E.even_count, 0)/(ifnull(W.win_count, 0) + ifnull(E.even_count, 0) + ifnull(L.lose_count, 0)) as even_rate,
                                       ifnull(L.lose_count, 0)/(ifnull(W.win_count, 0) + ifnull(E.even_count, 0) + ifnull(L.lose_count, 0)) as lose_rate
      from (select M.win_team_id, count(M.id) as win_count
            from (select M.id, M.home_team_id as win_team_id
                  from match_info M
                  where M.home_team_score > M.away_team_score
                  union
                  select M.id, M.away_team_id
                  from match_info M
                  where M.away_team_score > M.home_team_score) M
            group by M.win_team_id) W
      left join (select M.even_team_id, count(M.id) as even_count
                 from (select M.id, M.home_team_id as even_team_id
                       from match_info M
                       where M.home_team_score = M.away_team_score) M
                 group by M.even_team_id) E on E.even_team_id = W.win_team_id
      left join (select M.lose_team_id, count(M.id) as lose_count
                 from (select M.id, M.home_team_id as lose_team_id
                       from match_info M
                       where M.away_team_score > M.home_team_score
                       union 
                       select M.id, M.away_team_id
                       from match_info M
                       where M.home_team_score > M.away_team_score) M
                 group by M.lose_team_id) L on L.lose_team_id = W.win_team_id) W
left join (select B.win_team_id as team_id, B.avg_win_bet as B365_win_bet, B.avg_lose_bet as B365_lose_bet, B.avg_even_bet as B365_even_bet, 
                                            W.avg_win_bet as WH_win_bet, W.avg_lose_bet as WH_lose_bet, W.avg_even_bet as WH_even_bet, 
                                            S.avg_win_bet as SJ_win_bet, S.avg_lose_bet as SJ_lose_bet, S.avg_even_bet as SJ_even_bet
           from (select M.win_team_id, M.avg_win_bet, M2.avg_lose_bet, M3.avg_even_bet
                 from (select M.win_team_id, sum(M.B365H - 1)/count(M.win_team_id) as avg_win_bet
                       from (select M.id, M.home_team_id as win_team_id, M.B365H
                             from match_info M
                             where M.home_team_score > M.away_team_score
                             union
                             select M.id, M.away_team_id as win_team_id, M.B365A
                             from match_info M
                             where M.away_team_score > M.home_team_score) M
                       where M.B365H is not null
                       group by M.win_team_id) M
                 left join (select M.lose_team_id, sum(M.B365H - 1)/count(M.lose_team_id) as avg_lose_bet
                            from (select M.id, M.home_team_id as lose_team_id, M.B365H
                                  from match_info M
                                  where M.home_team_score < M.away_team_score
                                  union
                                  select M.id, M.away_team_id as lose_team_id, M.B365A
                                  from match_info M
                                  where M.away_team_score < M.home_team_score) M
                            where M.B365H is not null
                            group by M.lose_team_id) M2 on M2.lose_team_id = M.win_team_id
                 left join (select M.even_team_id, sum(M.B365H - 1)/count(M.even_team_id) as avg_even_bet
                            from (select M.id, M.home_team_id as even_team_id, M.B365H
                                  from match_info M
                                  where M.home_team_score = M.away_team_score
                                  union
                                  select M.id, M.away_team_id as even_team_id, M.B365A
                                  from match_info M
                                  where M.away_team_score = M.home_team_score) M
                            where M.B365H is not null
                            group by M.even_team_id) M3 on M3.even_team_id = M.win_team_id) B
           left join (select M.win_team_id, M.avg_win_bet, M2.avg_lose_bet, M3.avg_even_bet
                      from (select M.win_team_id, sum(M.WHH - 1)/count(M.win_team_id) as avg_win_bet
                            from (select M.id, M.home_team_id as win_team_id, M.WHH
                                  from match_info M
                                  where M.home_team_score > M.away_team_score
                                  union
                                  select M.id, M.away_team_id as win_team_id, M.WHA
                                  from match_info M
                                  where M.away_team_score > M.home_team_score) M
                            where M.WHH is not null
                            group by M.win_team_id) M
                      left join (select M.lose_team_id, sum(M.WHH - 1)/count(M.lose_team_id) as avg_lose_bet
                                 from (select M.id, M.home_team_id as lose_team_id, M.WHH
                                       from match_info M
                                       where M.home_team_score < M.away_team_score
                                       union
                                       select M.id, M.away_team_id as lose_team_id, M.WHA
                                       from match_info M
                                       where M.away_team_score < M.home_team_score) M
                                 where M.WHH is not null
                                 group by M.lose_team_id) M2 on M2.lose_team_id = M.win_team_id
                      left join (select M.even_team_id, sum(M.WHH - 1)/count(M.even_team_id) as avg_even_bet
                                 from (select M.id, M.home_team_id as even_team_id, M.WHH
                                       from match_info M
                                       where M.home_team_score = M.away_team_score
                                       union
                                       select M.id, M.away_team_id as even_team_id, M.WHA
                                       from match_info M
                                       where M.away_team_score = M.home_team_score) M
                                 where M.WHH is not null
                                 group by M.even_team_id) M3 on M3.even_team_id = M.win_team_id) W on W.win_team_id = B.win_team_id
           left join (select M.win_team_id, M.avg_win_bet, M2.avg_lose_bet, M3.avg_even_bet
                      from (select M.win_team_id, sum(M.SJH - 1)/count(M.win_team_id) as avg_win_bet
                            from (select M.id, M.home_team_id as win_team_id, M.SJH
                                  from match_info M
                                  where M.home_team_score > M.away_team_score
                                  union
                                  select M.id, M.away_team_id as win_team_id, M.SJA
                                  from match_info M
                                  where M.away_team_score > M.home_team_score) M
                            where M.SJH is not null
                            group by M.win_team_id) M
                      left join (select M.lose_team_id, sum(M.SJH - 1)/count(M.lose_team_id) as avg_lose_bet
                                 from (select M.id, M.home_team_id as lose_team_id, M.SJH
                                       from match_info M
                                       where M.home_team_score < M.away_team_score
                                       union
                                       select M.id, M.away_team_id as lose_team_id, M.SJA
                                       from match_info M
                                       where M.away_team_score < M.home_team_score) M
                                 where M.SJH is not null
                                 group by M.lose_team_id) M2 on M2.lose_team_id = M.win_team_id
                      left join (select M.even_team_id, sum(M.SJH - 1)/count(M.even_team_id) as avg_even_bet
                                 from (select M.id, M.home_team_id as even_team_id, M.SJH
                                       from match_info M
                                       where M.home_team_score = M.away_team_score
                                       union
                                       select M.id, M.away_team_id as even_team_id, M.SJA
                                       from match_info M
                                       where M.away_team_score = M.home_team_score) M
                                 where M.SJH is not null
                                 group by M.even_team_id) M3 on M3.even_team_id = M.win_team_id) S on S.win_team_id = B.win_team_id) E on E.team_id = W.team_id