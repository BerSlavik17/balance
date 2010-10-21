Balance::Application.routes.draw do
  resources :items do
    get :consolidates, :on => :collection 
  end

  constraints :year => /\d{4}/, :month => /\d{1,2}/, :day => /\d{1,2}/, :category => /[a-z_]+/ do
    match '/:year(/:month(/:day))(/:category)' => 'items#index', :via => :get
  end

  constraints :year => /\d{4}/, :month => /\d{1,2}/ do
    match '/items/consolidates/:year/:month' => 'items#consolidates', :via => :get
  end

  resources :cashes do
    get :at_end, :on => :collection
  end

  match '/at_begin' => 'cashes#at_begin', :via => :get
  match '/update_at_begin' => 'cashes#update_at_begin', :via => :put

  match '/balance' => 'cashes#balance'

  resources :settings

  root :to => 'items#index'
end
