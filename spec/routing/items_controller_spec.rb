require 'spec_helper'

describe ItemsController do
  it { expect(get: '/2011').to route_to(controller: 'items', action: 'index', year: '2011') }

  it { expect(get: '/2013/02').to route_to(controller: 'items', action: 'index', year: '2013', month: '02') }

  it { expect(get: '/2012/03/17').
    to route_to(controller: 'items', action: 'index', year: '2012', month: '03', day: '17') }

  it { expect(get: '/2010/food').
    to route_to(controller: 'items', action: 'index', year: '2010', category: 'food') }

  it { expect(get: '/2009/04/salary').
    to route_to(controller: 'items', action: 'index', year: '2009', month: '04', category: 'salary') }

  it { expect(get: '/2008/05/17/food').
    to route_to(controller: 'items', action: 'index', year: '2008', month: '05', day: '17', category: 'food') }
end
