class Oystercard
    attr_reader :balance, :MAX_BALANCE
    def initialize
        @balance = 0
        @MAX_BALANCE = 90
    end
    def top_up(amount)
        fail "cannot top up anymore, at maximum limit." if @balance + amount > @MAX_BALANCE
        @balance += amount
    end
end
