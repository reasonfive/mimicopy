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

  get '/scales/delete', to: 'scales#index'
  post '/scales/delete', to: 'scales#delete'


  get '/chords/index', to: 'chords#index'
  get '/chords/new', to: 'chords#new'

  get '/chords/confirm', to: 'chords#new'
  post '/chords/confirm', to: 'chords#confirm'

  get '/chords/create', to: 'chords#index'
  post '/chords/create', to: 'chords#create'

  get '/chords/search', to: 'chords#search'
  post '/chords/search', to: 'chords#search'

  get '/chords/delete', to: 'chords#index'
  post '/chords/delete', to: 'chords#delete'

end
