require 'journey'

describe Journey do
  let(:card) {double(:card)}
  let(:entry_station) {double(:station)}
  let(:exit_station) {double(:station)}

  let(:journey){ described_class.new }

  it { is_expected.to respond_to(:entry_station_name) }
  it { is_expected.to respond_to(:exit_station_name) }
  it { is_expected.to respond_to(:entry_station_zone) }
  it { is_expected.to respond_to(:exit_station_zone) }

  describe '#start_journey' do

    it 'remembers entry station' do
      journey.start_journey(entry_station)
      expect(journey.entry_station_name).to eq entry_station
    end
end
end
