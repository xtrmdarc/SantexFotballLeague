
class FootballDataApi

  @@endpoint = 'http://api.football-data.org/v2'
  @@primary_api_key = '80c02b7792c84bf6b7bab2e8f3f03f07'

  @@headers = {
    'X-Auth-Token' => @@primary_api_key
  }

  def self.teams_by_league(league_code)
    response = RestClient.get "#{@@endpoint}/competitions/#{league_code}/teams", @@headers
    return response.body
  end

  def self.players_by_team(team_id, key = nil)
    headers = @@headers
    headers['X-Auth-Token'] = key if key
    response = RestClient.get "#{@@endpoint}/teams/#{team_id}", headers
    return response.body
  end
end
