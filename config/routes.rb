Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  root 'parties#index'

  get '/login', to: 'sessions#new', as: :login
  get '/logout', to: 'sessions#destroy', as: :logout
  get '/auth/spotify', as: :spotify_oauth
  get '/auth/spotify/callback', to: 'sessions#create', as: :spotify_callback
  get '/soundcheck', to: 'host/parties#edit', as: :soundcheck
  get '/admissions', to: 'parties#new', as: :admissions
  post '/admissions', to: 'parties#create', as: :join_party
  get '/party', to: 'parties#show', as: :party
  delete '/party', to: 'parties#delete', as: :leave_party
  get '/legal', to: 'legal#show', as: :legal
  get '/host', to: 'host/parties#show', as: :host_party
  put '/host', to: 'host/parties#update', as: :update_host_party
  delete '/host/party', to: 'host/parties#destroy', as: :cancel_party

  namespace :api do
    namespace :v1 do
      scope :me, module: :me do
        get '/available_devices', to: 'devices#index', as: :available_devices
        get '/track_status',to: 'track_status#show', as: :track_status
        get '/save_track', to: 'track_status#create', as: :save_track
        get '/currently_playing', to: 'tracks#show', as: :currently_playing
        put '/start_playback', to: 'tracks#update', as: :start_playback

        namespace :tracks do
          get '/skip_track', to: 'skip#update', as: :skip_track
        end

        scope :playback, module: :playback do
          put '/toggle', to: 'pause_play#update', as: :toggle_playback
        end
      end
    end
  end
end
