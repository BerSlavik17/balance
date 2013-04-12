require 'spec_helper'

describe ItemsController do
  it { should be_a InheritedResources::Base }

  its(:mimes_for_respond_to) { should include :html }
  
  its(:mimes_for_respond_to) { should include :js }

  it { should route(:post, '/items').to(action: :create) }

  it { should route(:get, '/items/1/edit').to(action: :edit, id: 1) }

  it { should route(:put, '/items/1').to(action: :update, id: 1) }

  it { should route(:get, '/2011').to(action: :index, year: '2011') }
  
  it { should route(:get, '/2011').to(action: :index, year: '2011') }

  it { should route(:get, '/2013/02').to(action: :index, year: '2013', month: '02') }

  it { should route(:get, '/2012/03/17').to(action: :index, year: '2012', month: '03', day: '17') }

  it { should route(:get, '/2010/food').to(action: :index, year: '2010', category: 'food') }

  it { should route(:get, '/2009/04/salary').to(action: :index, year: '2009', month: '04', category: 'salary') }

  it { should route(:get, '/2008/05/17/food').
    to(action: :index, year: '2008', month: '05', day: '17', category: 'food') }
end
