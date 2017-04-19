require 'station'
describe Station do

it 'stores the name of a station' do
  station = Station.new('Liverpool Street', 3)
  expect(station.name).to eq 'Liverpool Street'
end
it 'stores the zone of the station' do
  station = Station.new('Liverpool Street', 3)
  expect(station.zone).to eq 3
end
end
