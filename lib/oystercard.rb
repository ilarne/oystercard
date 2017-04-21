require_relative 'journey'
require_relative 'station'

class Oystercard
  attr_reader :balance, :journey_history, :journey
  DEFAULT_LIMIT = 90
  MINIMUM_BALANCE = 1
  PENALTY_FARE = 6

  def initialize
    @balance = 0
    @journey_history = []
    @journey = Journey.new
  end

  def top_up(amount)
    raise "Top-up would exceed £#{DEFAULT_LIMIT} limit" if @balance + amount > DEFAULT_LIMIT
    @balance += amount
  end

  def touch_in(station)
    raise 'Insufficient funds!' if @balance < MINIMUM_BALANCE
#    station = Station.new(name, zone)
    deduct(PENALTY_FARE) if !@journey.entry_station_name.nil?
    @journey.start_journey(station)
  end

  def touch_out(station)
    #deduct(@journey.fare)
    @journey.end_journey(station)
    @journey_history << { entry_station: @journey.entry_station_name, exit_station: @journey.exit_station_name }
    deduct(@journey.fare)
    @journey.entry_station_name = nil
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
