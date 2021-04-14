select L.name, L2.win_count/L1.all_count as prob
from league L
inner join (select L.id, count(L.avg_height) as all_count
            from (select L.id, M1.home_avg_height as avg_height
                        from league L
                        left join (select M.league_id, (if(P1.height, P1.height, 0) + if(P2.height, P2.height, 0) + if(P3.height, P3.height, 0) + if(P4.height, P4.height, 0) + if(P5.height, P5.height, 0) + if(P6.height, P6.height, 0) + if(P7.height, P7.height, 0) + if(P8.height, P8.height, 0) + if(P9.height, P9.height, 0) + if(P10.height, P10.height, 0) + if(P11.height, P11.height, 0))/
                                  (if(P1.player_api_id, 1, 0) + if(P2.player_api_id, 1, 0) + if(P3.player_api_id, 1, 0) + if(P4.player_api_id, 1, 0) + if(P5.player_api_id, 1, 0) + if(P6.player_api_id, 1, 0) + if(P7.player_api_id, 1, 0) + if(P8.player_api_id, 1, 0) + if(P9.player_api_id, 1, 0) + if(P10.player_api_id, 1, 0) + if(P11.player_api_id, 1, 0)) as home_avg_height
                                    from match_info M
                                    left join (select P.player_api_id, P.height from player P) P1 on P1.player_api_id = M.home_player_1 
                                    left join (select P.player_api_id, P.height from player P) P2 on P2.player_api_id = M.home_player_2
                                    left join (select P.player_api_id, P.height from player P) P3 on P3.player_api_id = M.home_player_3
                                    left join (select P.player_api_id, P.height from player P) P4 on P4.player_api_id = M.home_player_4
                                    left join (select P.player_api_id, P.height from player P) P5 on P5.player_api_id = M.home_player_5
                                    left join (select P.player_api_id, P.height from player P) P6 on P6.player_api_id = M.home_player_6
                                    left join (select P.player_api_id, P.height from player P) P7 on P7.player_api_id = M.home_player_7
                                    left join (select P.player_api_id, P.height from player P) P8 on P8.player_api_id = M.home_player_8
                                    left join (select P.player_api_id, P.height from player P) P9 on P9.player_api_id = M.home_player_9
                                    left join (select P.player_api_id, P.height from player P) P10 on P10.player_api_id = M.home_player_10
                                    left join (select P.player_api_id, P.height from player P) P11 on P11.player_api_id = M.home_player_11
                                    where M.season = '2015/2016') M1 on L.id = M1.league_id and M1.home_avg_height > 180
                        union all
                        select L.id, M2.away_avg_height as avg_height
                        from league L            
                        left join (select M.league_id, (if(P1.height, P1.height, 0) + if(P2.height, P2.height, 0) + if(P3.height, P3.height, 0) + if(P4.height, P4.height, 0) + if(P5.height, P5.height, 0) + if(P6.height, P6.height, 0) + if(P7.height, P7.height, 0) + if(P8.height, P8.height, 0) + if(P9.height, P9.height, 0) + if(P10.height, P10.height, 0) + if(P11.height, P11.height, 0))/
                                  (if(P1.player_api_id, 1, 0) + if(P2.player_api_id, 1, 0) + if(P3.player_api_id, 1, 0) + if(P4.player_api_id, 1, 0) + if(P5.player_api_id, 1, 0) + if(P6.player_api_id, 1, 0) + if(P7.player_api_id, 1, 0) + if(P8.player_api_id, 1, 0) + if(P9.player_api_id, 1, 0) + if(P10.player_api_id, 1, 0) + if(P11.player_api_id, 1, 0)) as away_avg_height
                                    from match_info M
                                    left join (select P.player_api_id, P.height from player P) P1 on P1.player_api_id = M.away_player_1 
                                    left join (select P.player_api_id, P.height from player P) P2 on P2.player_api_id = M.away_player_2
                                    left join (select P.player_api_id, P.height from player P) P3 on P3.player_api_id = M.away_player_3
                                    left join (select P.player_api_id, P.height from player P) P4 on P4.player_api_id = M.away_player_4
                                    left join (select P.player_api_id, P.height from player P) P5 on P5.player_api_id = M.away_player_5
                                    left join (select P.player_api_id, P.height from player P) P6 on P6.player_api_id = M.away_player_6
                                    left join (select P.player_api_id, P.height from player P) P7 on P7.player_api_id = M.away_player_7
                                    left join (select P.player_api_id, P.height from player P) P8 on P8.player_api_id = M.away_player_8
                                    left join (select P.player_api_id, P.height from player P) P9 on P9.player_api_id = M.away_player_9
                                    left join (select P.player_api_id, P.height from player P) P10 on P10.player_api_id = M.away_player_10
                                    left join (select P.player_api_id, P.height from player P) P11 on P11.player_api_id = M.away_player_11
                                    where M.season = '2015/2016') M2 on L.id = M2.league_id and M2.away_avg_height > 180) L
            group by L.id) L1 on L.id = L1.id
inner join (select L.id, count(L.avg_height) as win_count
            from (select L.id, M1.home_avg_height as avg_height
                        from league L
                        left join (select M.league_id, (if(P1.height, P1.height, 0) + if(P2.height, P2.height, 0) + if(P3.height, P3.height, 0) + if(P4.height, P4.height, 0) + if(P5.height, P5.height, 0) + if(P6.height, P6.height, 0) + if(P7.height, P7.height, 0) + if(P8.height, P8.height, 0) + if(P9.height, P9.height, 0) + if(P10.height, P10.height, 0) + if(P11.height, P11.height, 0))/
                                  (if(P1.player_api_id, 1, 0) + if(P2.player_api_id, 1, 0) + if(P3.player_api_id, 1, 0) + if(P4.player_api_id, 1, 0) + if(P5.player_api_id, 1, 0) + if(P6.player_api_id, 1, 0) + if(P7.player_api_id, 1, 0) + if(P8.player_api_id, 1, 0) + if(P9.player_api_id, 1, 0) + if(P10.player_api_id, 1, 0) + if(P11.player_api_id, 1, 0)) as home_avg_height, M.home_team_score, M.away_team_score
                                    from match_info M
                                    left join (select P.player_api_id, P.height from player P) P1 on P1.player_api_id = M.home_player_1 
                                    left join (select P.player_api_id, P.height from player P) P2 on P2.player_api_id = M.home_player_2
                                    left join (select P.player_api_id, P.height from player P) P3 on P3.player_api_id = M.home_player_3
                                    left join (select P.player_api_id, P.height from player P) P4 on P4.player_api_id = M.home_player_4
                                    left join (select P.player_api_id, P.height from player P) P5 on P5.player_api_id = M.home_player_5
                                    left join (select P.player_api_id, P.height from player P) P6 on P6.player_api_id = M.home_player_6
                                    left join (select P.player_api_id, P.height from player P) P7 on P7.player_api_id = M.home_player_7
                                    left join (select P.player_api_id, P.height from player P) P8 on P8.player_api_id = M.home_player_8
                                    left join (select P.player_api_id, P.height from player P) P9 on P9.player_api_id = M.home_player_9
                                    left join (select P.player_api_id, P.height from player P) P10 on P10.player_api_id = M.home_player_10
                                    left join (select P.player_api_id, P.height from player P) P11 on P11.player_api_id = M.home_player_11
                                    where M.season = '2015/2016') M1 on L.id = M1.league_id and M1.home_avg_height > 180 and M1.home_team_score > M1.away_team_score
                        union all
                        select L.id, M2.away_avg_height as avg_height
                        from league L            
                        left join (select M.league_id, (if(P1.height, P1.height, 0) + if(P2.height, P2.height, 0) + if(P3.height, P3.height, 0) + if(P4.height, P4.height, 0) + if(P5.height, P5.height, 0) + if(P6.height, P6.height, 0) + if(P7.height, P7.height, 0) + if(P8.height, P8.height, 0) + if(P9.height, P9.height, 0) + if(P10.height, P10.height, 0) + if(P11.height, P11.height, 0))/
                                  (if(P1.player_api_id, 1, 0) + if(P2.player_api_id, 1, 0) + if(P3.player_api_id, 1, 0) + if(P4.player_api_id, 1, 0) + if(P5.player_api_id, 1, 0) + if(P6.player_api_id, 1, 0) + if(P7.player_api_id, 1, 0) + if(P8.player_api_id, 1, 0) + if(P9.player_api_id, 1, 0) + if(P10.player_api_id, 1, 0) + if(P11.player_api_id, 1, 0)) as away_avg_height, M.home_team_score, M.away_team_score
                                    from match_info M
                                    left join (select P.player_api_id, P.height from player P) P1 on P1.player_api_id = M.away_player_1 
                                    left join (select P.player_api_id, P.height from player P) P2 on P2.player_api_id = M.away_player_2
                                    left join (select P.player_api_id, P.height from player P) P3 on P3.player_api_id = M.away_player_3
                                    left join (select P.player_api_id, P.height from player P) P4 on P4.player_api_id = M.away_player_4
                                    left join (select P.player_api_id, P.height from player P) P5 on P5.player_api_id = M.away_player_5
                                    left join (select P.player_api_id, P.height from player P) P6 on P6.player_api_id = M.away_player_6
                                    left join (select P.player_api_id, P.height from player P) P7 on P7.player_api_id = M.away_player_7
                                    left join (select P.player_api_id, P.height from player P) P8 on P8.player_api_id = M.away_player_8
                                    left join (select P.player_api_id, P.height from player P) P9 on P9.player_api_id = M.away_player_9
                                    left join (select P.player_api_id, P.height from player P) P10 on P10.player_api_id = M.away_player_10
                                    left join (select P.player_api_id, P.height from player P) P11 on P11.player_api_id = M.away_player_11
                                    where M.season = '2015/2016') M2 on L.id = M2.league_id and M2.away_avg_height > 180 and M2.away_team_score > M2.home_team_score) L
            group by L.id) L2 on L.id = L2.id
order by L.name;