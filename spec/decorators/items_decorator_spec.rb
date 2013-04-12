require 'spec_helper'

describe ItemsDecorator do
  subject { ItemsDecorator.new [] }

  it { should be_a Draper::CollectionDecorator }
end
