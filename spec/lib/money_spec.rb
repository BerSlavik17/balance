require 'spec_helper'

describe Money do
  subject { Money.new 100.5 }

  it { should eq '100.50' }

  its(:to_f) { should eq 100.50 }

  it 'should addition furmula' do
    expect(Money.new '10.5 + 20.3').to eq '30.80'
  end

  it 'should subtraction formula' do
    expect(Money.new '9.8 - 8.6').to eq '1.20'
  end

  its(:source) { should eq '100.5' }

  it 'should remove invalid characters' do
    expect(Money.new('2.1+1..9---34abc+x^y+5').source).to eq '2.1+1.9-34+5'
  end
end
