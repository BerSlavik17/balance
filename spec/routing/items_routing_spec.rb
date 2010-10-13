require 'spec_helper'

describe ItemsController do
  it do
    { :get => '/items/consolidates' }.should route_to(:action => 'consolidates', :controller => 'items')
  end

  it do
    { :get => '/items/consolidates/2010/10' }.should route_to(:action => 'consolidates', :controller => 'items', :year => '2010', :month => '10')
  end
end

