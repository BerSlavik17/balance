require 'spec_helper'

describe Money do
  subject { Money.new 100_300.564 }

  it { should eq 100_300.56 }

  its(:to_f) { should eq 100_300.56 }

  it 'should addition furmula' do
    expect(Money.new '10.57 + 20.3').to eq 30.87
  end

  it 'should subtraction formula' do
    expect(Money.new '9.85 - 8.6').to eq 1.25
  end

  its(:source) { should eq '100300.564' }

  it 'should remove invalid characters' do
    expect(Money.new('2.1+1..9---34abc+x^y+5').source).to eq '2.1+1.9-34+5'
  end
end
