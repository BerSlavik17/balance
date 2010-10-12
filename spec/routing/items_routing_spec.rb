require 'spec_helper'

describe ItemsController do
  it do
    { :get => '/items/consolidates' }.should route_to(:action => 'consolidates', :controller => 'items')
  end
end

