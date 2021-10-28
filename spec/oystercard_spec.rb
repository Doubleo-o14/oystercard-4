require 'oystercard'

describe Oystercard do

    describe '#balance' do
      it "has a balance of 0 on initalization" do
          card = Oystercard.new
          expect(card.balance).to eq(0)
      end
    end
    
    describe '#top_up' do
      it "add money to your card up" do
        expect { subject.top_up 10 }.to change { subject.balance }.by(10)
      end
      
      it "raise an error if balance exceeds maximum balance" do
        maximum_balance = Oystercard::MAXIMUM_BALANCE
        subject.top_up(maximum_balance)
        expect{ subject.top_up(1) }.to raise_error "Maximum balance exceeded"
      end
    end

    describe "#deduct" do
      it "deducts minimum_fare from balance" do
        minimum_fare = Oystercard::MININMUM_FARE
        expect { subject.deduct(minimum_fare) }.to change { subject.balance }.by(-minimum_fare)
      end
    end

    #### REFACTORED UP TO HERE

    describe "#touch in" do
      it "enter trainstation and starting journey" do
        expect(subject.touch_in).to eq true
      end
      it "raise an error of insufficent funds" do
        expect{ subject.touch_in }.to raise_error "no funds"
      end
    end
    describe "#touch out" do
      it "leaving train station and ending journey" do
        expect(subject.touch_out).to eq false
      end
    end
end
