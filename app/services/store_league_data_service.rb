
class StoreLeagueDataService
  @@keychain = [
    '154dc7ded7504bd3a8f484eb662970fe',
    '4f6770311927418bbf6cac2b18c3b7af',
    '5d45560fffbe400b85cfbc62cde453b0',
    '20a0a7fa45624abb9c996fc6fa6f92df',
    'b47279143dc14272bd92090847e090e0',
    '127f78280b8b454084f6b046ef732c9d',
    'bfd2736a442d4c569421f032b690c2f9',
    '48f32fe52b044b01a00778618d812511',
    '601c818373544deea28e6072823c0765',
    'd9d083911be7440288bdd6de44655107'
  ]

  def self.save(league_code)
    data = JSON.parse FootballDataApi.teams_by_league(league_code)
    dbComp = Competition.create name: data['competition']['name'], 
            code: data['competition']['code'],
            areaName: data['competition']['area']['name']

    return {'error' => 'comp already exists'} unless dbComp.valid?

    call_count = 0
    key_index = 0
    data['teams'].each do |team|

      if call_count >= 10
        key_index = self.refresh_key(key_index)
        call_count = 0
      end
      use_key = @@keychain[key_index]

      team_data = JSON.parse FootballDataApi.players_by_team team['id'], use_key
      call_count += 1

      dbTeam = Team.create name: team['name'], 
                tla: team['tla'],
                shortName: team['shortName'],
                areaName: team['area']['name'],
                email: team['email']
                
      dbComp.competition_teams.create(team: dbTeam)

      players = team_data['squad']
      players.each do |player|
        Player.create name: player['name'],
          position: player['position'],
          dateOfBirth: player['dateOfBirth'],
          countryOfBirth: player['countryOfBirth'],
          nationality: player['nationality'],
          team_id: dbTeam.id
      end
    end
  end

  private 

  def self.refresh_key(key_index)
    key_index + 1 % @@keychain.length
  end
end
