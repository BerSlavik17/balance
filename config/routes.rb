Balans::Application.routes.draw do
  resources :items, :cashes

  constraints :year => /\d{4}/, :month => /\d{1,2}/, :day => /\d{1,2}/, :category => /[a-z_]+/ do
    match '/:year(/:month(/:day))(/:category)' => 'items#index', :via => :get
  end

  match '/at_begin' => 'settings#at_begin', :as => :at_begin

  resources :settings

  root :to => 'items#index'
end
