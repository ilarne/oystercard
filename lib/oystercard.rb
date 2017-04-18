class Oystercard
  attr_reader :balance, :in_use
  DEFAULT_LIMIT = 90
  MINIMUM_BALANCE = 1

  def initialize
    @balance = 0
    @in_use = false
  end

  def top_up(amount)
    fail "Top-up would exceed £#{DEFAULT_LIMIT} limit" if @balance + amount > DEFAULT_LIMIT
    @balance += amount
  end

  def spend(amount)
    @balance -= amount
  end

  def in_journey?
  @in_use
  end

  def touch_in
   fail "insufficient funds !" if @balance < MINIMUM_BALANCE
   @in_use = true
  end

  def touch_out
   @in_use = false
  end

end
