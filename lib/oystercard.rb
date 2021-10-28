class Oystercard
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  MINIMUM_FARE = 1
  attr_reader :balance, :entry_station, :exit_station

  def initialize
    @balance = 0
    @entry_station = nil
    @exit_station = nil
  end

  def top_up(amount)
    fail "Maximum balance exceeded" if @balance + amount > MAXIMUM_BALANCE
      @balance += amount
  end

  def touch_in(station)
    fail "Insufficient balance on card" if balance < MINIMUM_BALANCE
    @entry_station = station
  end

  def touch_out(station)
    deduct(MINIMUM_FARE)
    @entry_station = nil
    @exit_station = station
  end

  def in_journey?
    if @entry_station == nil
      false
    else
      true
    end
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
