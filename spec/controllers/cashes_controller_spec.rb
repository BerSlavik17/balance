require 'spec_helper'

describe CashesController do
  it { should be_a InheritedResources::Base }

  its(:mimes_for_respond_to) { should include :js }

  it { should have_helper_method :cashes }
end
