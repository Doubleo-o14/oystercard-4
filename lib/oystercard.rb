class Oystercard
    attr_reader :balance, :MAX_BALANCE
    def initialize
        @balance = 0
        @MAX_BALANCE = 90
        @in_journey = false
    end
    def top_up(amount)
        fail "cannot top up anymore, at maximum limit." if @balance + amount > @MAX_BALANCE
        @balance += amount
    end

    def deduct
        @balance -= 1
    end

    def touch_in
        @in_journey = true
    end

    def touch_out
        @in_journey = false
    end

    def in_journey
    end
end
