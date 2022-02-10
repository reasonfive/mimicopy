Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'top#index'

  get '/scales/index', to: 'scales#index'
  get '/scales/new', to: 'scales#new'

  get '/scales/confirm', to: 'scales#new'
  post '/scales/confirm', to: 'scales#confirm'

  get '/scales/create', to: 'scales#index'
  post '/scales/create', to: 'scales#create'

  get '/scales/search', to: 'scales#search'
  post '/scales/search', to: 'scales#search'
  

end
