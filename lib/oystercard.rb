class Oystercard

  attr_reader :balance, :in_use, :entry_station, :journey, :exit_station
  DEFAULT_LIMIT = 90
  MINIMUM_BALANCE = 1

  def initialize
    @balance = 0
    @entry_station
    @exit_station
    @journey = {journey: nil}
  end

  def top_up(amount)
    fail "Top-up would exceed £#{DEFAULT_LIMIT} limit" if @balance + amount > DEFAULT_LIMIT
    @balance += amount
  end

  def in_journey?
  @entry_station.nil? ? false : true
  end

  def touch_in(station)
   fail "insufficient funds !" if @balance < MINIMUM_BALANCE
   @entry_station = station
  end

  def touch_out(station)
   deduct(MINIMUM_BALANCE)
   @exit_station = station
   @journey[:journey] = [@entry_station, @exit_station]
   @entry_station = nil
  end

private

  def deduct(amount)
    @balance -= amount
  end

end
