Balans3::Application.routes.draw do
  resources :items, :cashes

  constraints :year => /\d{4}/, :month => /\d{1,2}/, :day => /\d{1,2}/, :category => /[a-z_]+/ do
    match '/:year(/:month(/:day))(/:category)' => 'items#index', :via => :get
  end

  root :to => 'items#index'
end
