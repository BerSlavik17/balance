require 'spec_helper'

describe CashesDecorator do
  subject { CashesDecorator.new [] }

  it { should be_a Draper::CollectionDecorator }
end
