Balance::Application.routes.draw do
  resources :items, only: [:create, :edit, :update]

  constraints :year => /\d{4}/, :month => /\d{1,2}/, :day => /\d{1,2}/, :category => /[a-z_]+/ do
    get '/(:year(/:month)(/:category))' => 'items#index'
  end

  resources :cashes

  root to: 'items#index'
end
