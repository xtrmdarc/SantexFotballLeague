Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/import-league/:league_code', to: 'competitions#import'
  get '/total-players/:league_code', to: 'players#total'

  match '*path', to: "application#not_found", via: [:get, :post]
end
