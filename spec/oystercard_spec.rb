require 'oystercard'

describe Oystercard do

  it { is_expected.to respond_to(:balance) }

  it 'initializes with a balance of zero' do
    expect(subject.balance).to eq 0
  end

  it { is_expected.to respond_to(:top_up).with(1).argument }

describe '#top_up' do
  it 'tops up balance by specified amount' do
    subject.top_up(15)
    expect(subject.balance).to eq 15
end

  it 'raises an error if top-up would push balance above £90' do
     expect{ subject.top_up(100) }.to raise_error "Top-up would exceed £#{Oystercard::DEFAULT_LIMIT} limit"
  end

end


end
