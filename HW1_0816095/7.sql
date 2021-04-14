select P.preferred_foot, round(avg(P.long_shots), 2)
from player_attributes P
inner join (select distinct M.home_player_1 as player_api_id
      from match_info M, league L
      where M.league_id = L.id and L.name = 'Italy Serie A' and M.season = '2015/2016'
      union
      select distinct M.home_player_2 as player_api_id
      from match_info M, league L
      where M.league_id = L.id and L.name = 'Italy Serie A' and M.season = '2015/2016'
      union
      select distinct M.home_player_3 as player_api_id
      from match_info M, league L
      where M.league_id = L.id and L.name = 'Italy Serie A' and M.season = '2015/2016'
      union
      select distinct M.home_player_4 as player_api_id
      from match_info M, league L
      where M.league_id = L.id and L.name = 'Italy Serie A' and M.season = '2015/2016'
      union
      select distinct M.home_player_5 as player_api_id
      from match_info M, league L
      where M.league_id = L.id and L.name = 'Italy Serie A' and M.season = '2015/2016'
      union
      select distinct M.home_player_6 as player_api_id
      from match_info M, league L
      where M.league_id = L.id and L.name = 'Italy Serie A' and M.season = '2015/2016'
      union
      select distinct M.home_player_7 as player_api_id
      from match_info M, league L
      where M.league_id = L.id and L.name = 'Italy Serie A' and M.season = '2015/2016'
      union
      select distinct M.home_player_8 as player_api_id
      from match_info M, league L
      where M.league_id = L.id and L.name = 'Italy Serie A' and M.season = '2015/2016'
      union
      select distinct M.home_player_9 as player_api_id
      from match_info M, league L
      where M.league_id = L.id and L.name = 'Italy Serie A' and M.season = '2015/2016'
      union
      select distinct M.home_player_10 as player_api_id
      from match_info M, league L
      where M.league_id = L.id and L.name = 'Italy Serie A' and M.season = '2015/2016'
      union
      select distinct M.home_player_11 as player_api_id
      from match_info M, league L
      where M.league_id = L.id and L.name = 'Italy Serie A' and M.season = '2015/2016'
      union

      select distinct M.away_player_1 as player_api_id
      from match_info M, league L
      where M.league_id = L.id and L.name = 'Italy Serie A' and M.season = '2015/2016'
      union
      select distinct M.away_player_2 as player_api_id
      from match_info M, league L
      where M.league_id = L.id and L.name = 'Italy Serie A' and M.season = '2015/2016'
      union
      select distinct M.away_player_3 as player_api_id
      from match_info M, league L
      where M.league_id = L.id and L.name = 'Italy Serie A' and M.season = '2015/2016'
      union
      select distinct M.away_player_4 as player_api_id
      from match_info M, league L
      where M.league_id = L.id and L.name = 'Italy Serie A' and M.season = '2015/2016'
      union
      select distinct M.away_player_5 as player_api_id
      from match_info M, league L
      where M.league_id = L.id and L.name = 'Italy Serie A' and M.season = '2015/2016'
      union
      select distinct M.away_player_6 as player_api_id
      from match_info M, league L
      where M.league_id = L.id and L.name = 'Italy Serie A' and M.season = '2015/2016'
      union
      select distinct M.away_player_7 as player_api_id
      from match_info M, league L
      where M.league_id = L.id and L.name = 'Italy Serie A' and M.season = '2015/2016'
      union
      select distinct M.away_player_8 as player_api_id
      from match_info M, league L
      where M.league_id = L.id and L.name = 'Italy Serie A' and M.season = '2015/2016'
      union
      select distinct M.away_player_9 as player_api_id
      from match_info M, league L
      where M.league_id = L.id and L.name = 'Italy Serie A' and M.season = '2015/2016'
      union
      select distinct M.away_player_10 as player_api_id
      from match_info M, league L
      where M.league_id = L.id and L.name = 'Italy Serie A' and M.season = '2015/2016'
      union
      select distinct M.away_player_11 as player_api_id
      from match_info M, league L
      where M.league_id = L.id and L.name = 'Italy Serie A' and M.season = '2015/2016') A on P.player_api_id = A.player_api_id
inner join (select P.player_api_id, max(P.date) as maxdate
      from player_attributes P
      group by P.player_api_id) A1 on P.date = A1.maxdate and A1.player_api_id = P.player_api_id
group by P.preferred_foot;