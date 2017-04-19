class Oystercard #understands information about card balance
  attr_reader :balance, :entry_station, :journey_history, :exit_station
  DEFAULT_LIMIT = 90
  MINIMUM_BALANCE = 1

  def initialize
    @balance = 0
    @journey_history = []
  end

  def top_up(amount)
    raise "Top-up would exceed £#{DEFAULT_LIMIT} limit" if @balance + amount > DEFAULT_LIMIT
    @balance += amount
  end

  def in_journey?
    @entry_station.nil? ? false : true
  end

  def touch_in(station)
    raise 'Insufficient funds!' if @balance < MINIMUM_BALANCE
    @entry_station = station
  end

  def touch_out(station)
    deduct(MINIMUM_BALANCE)
    @exit_station = station
    @journey_history << {entry_station: @entry_station, exit_station: @exit_station}
    @entry_station = nil
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
