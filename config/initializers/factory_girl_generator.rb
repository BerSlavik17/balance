Balance::Application.configure do 
  config.generators do |g|
    g.test_framework :test_unit, :fixtures => false, :fixture_replacement => :factory_girl
  end
end
