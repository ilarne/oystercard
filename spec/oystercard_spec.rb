require 'oystercard'

describe Oystercard do
  let (:station){ double(:station) }
  let (:journey){ double(:journey) }

  let (:card){ described_class.new }

  it { is_expected.to respond_to(:balance) }

  it 'initializes with a balance of zero' do
    expect(card.balance).to eq 0
  end

  it 'checks card has empty journey history by default' do
    expect(card.journey_history).to eq []
  end

  before do
  allow(station).to receive_messages(:name => "Camden", :zone => 3 )
  end
  it 'charges a penalty fare for not touching out' do
    card.top_up(10)
    card.touch_in(station)
    expect { card.touch_in(station) }.to change { card.balance }.by(-Oystercard::PENALTY_FARE)
  end

  it { is_expected.to respond_to(:top_up).with(1).argument }

  describe '#top_up' do
    it 'tops up balance by specified amount' do
      card.top_up(15)
      expect(card.balance).to eq 15
    end

    it 'raises an error if top-up would push balance above £90' do
      expect{ card.top_up(100) }.to raise_error "Top-up would exceed £#{Oystercard::DEFAULT_LIMIT} limit"
    end
  end

  describe '#deduct' do
    it 'reduces balance by given amount' do
      card.top_up(50)
      expect(card.send(:deduct, 40)).to eq 10
    end
  end

  describe '#in_journey?' do
    it 'expect journey to be false to begin with' do
      expect(card.in_journey?).to be(false)
    end
  end

  describe '#touch_in' do
    before do
      allow(station).to receive_messages(:name => "Camden", :zone => 3 )
      allow(journey).to receive_messages(:entry_station_name => "Camden")
    end
    it 'makes in journey status true' do
      card.top_up(3)
      card.touch_in(station)
      expect(card.in_journey?).to eq true
    end

    it 'raises and error if balance is less than minimum charge' do
      expect { card.touch_in(station) }.to raise_error 'Insufficient funds!'
    end

    it 'creates a new instance of journey' do
      card.top_up(3)
      card.touch_in(station)
      expect(card.journey.entry_station_name).to eq journey.entry_station_name
    end
  end

  describe '#((touch_out(station)' do
    before do
      allow(station).to receive_messages(:name => "Dalston", :zone => 5)
      allow(journey).to receive_messages(:exit_station_name => "Dalston")
    end
    it 'makes in journey status false' do
      card.touch_out(station)
      expect(card.in_journey?).to eq false
    end

    it 'deducts fare upon touching out' do
      expect { card.touch_out(station) }.to change{ card.balance }.by(-Oystercard::MINIMUM_BALANCE)
    end

    it 'creates an exit station on touch out' do
      card.touch_out(station)
      expect(card.journey.exit_station_name).to eq station.name
    end

    it 'saves to journey history upon touching out' do
      card.top_up(Oystercard::MINIMUM_BALANCE)
      card.touch_in(station)
      card.touch_out(station)
      expect(card.journey_history).to eq ( [ { entry_station: station.name, exit_station: station.name } ])
    end
  end
end
