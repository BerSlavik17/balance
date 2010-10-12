require 'spec_helper'

describe CashesController do
  it do
    { :get => '/cashes/at_end' }.should route_to(:action => 'at_end', :controller => 'cashes')
  end

  it do
    { :get => '/balance' }.should route_to(:action => 'balance', :controller => 'cashes')
  end
end
