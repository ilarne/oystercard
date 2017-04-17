class Oystercard
  attr_reader :balance
  DEFAULT_LIMIT = 90

  def initialize
    @balance = 0
  end

  def top_up(amount)
    fail "Top-up would exceed £#{DEFAULT_LIMIT} limit" if @balance + amount > DEFAULT_LIMIT
    @balance += amount
  end
end
