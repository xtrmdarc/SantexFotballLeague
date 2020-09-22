
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
    begin
      data = JSON.parse FootballDataApi.teams_by_league(league_code)

      dbComp = self.store_competition data
      return self.craft_response 'League already imported', 409 unless dbComp.valid?

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

        dbTeam = Team.find_by(name: team['name'])

        if dbTeam
          dbComp.competition_teams.create(team: dbTeam)
          next
        end

        dbTeam = self.store_team team
        dbComp.competition_teams.create(team: dbTeam)

        players = team_data['squad']
        players_to_insert = []
        players.each do |player|
          players_to_insert.push self.new_player player, dbTeam.id
        end
        Player.import players_to_insert, on_duplicate_key_ignore: true
      end
      return self.craft_response 'Successfully imported', 201
    rescue RestClient::Forbidden => e
      return self.craft_response 'Not found in free tier', 403
    rescue RestClient::NotFound => e
      return self.craft_response 'Not found', 404
    rescue StandardError => e
      return self.craft_response 'Server Error', 504
    end
  end

  private 

  def self.refresh_key(key_index)
    key_index + 1 % @@keychain.length
  end

  def self.store_competition(data)
    Competition.create name: data['competition']['name'], 
      code: data['competition']['code'],
      areaName: data['competition']['area']['name']
  end

  def self.store_team(team)
    Team.create name: team['name'], 
      tla: team['tla'],
      shortName: team['shortName'],
      areaName: team['area']['name'],
      email: team['email']
  end

  def self.store_player(player, team_id)
    Player.create name: player['name'],
      position: player['position'],
      dateOfBirth: player['dateOfBirth'],
      countryOfBirth: player['countryOfBirth'],
      nationality: player['nationality'],
      team_id: team_id
  end

  def self.new_player(player, team_id)
    Player.create name: player['name'],
      position: player['position'],
      dateOfBirth: player['dateOfBirth'],
      countryOfBirth: player['countryOfBirth'],
      nationality: player['nationality'],
      team_id: team_id
  end
  
  def self.craft_response(message, status)
    {
      response: {
        message: message
      },
      status: status
    }
  end
end
