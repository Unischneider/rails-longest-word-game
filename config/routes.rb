Rails.application.routes.draw do
  root to: 'games#home'

  get 'home', to: 'games#home'

  get 'new', to: 'games#new'

  post 'score', to: 'games#score'

  get 'score', to: 'games#score'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
