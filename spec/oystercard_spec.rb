require './lib/oystercard'

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
    it "deducts 1 from balance" do
      expect { subject.deduct(1) }.to change { subject.balance }.by(-1)
    end
  end

  describe '#in_journey?' do
    context "when oystercard is initalized it" do
      it "is false" do
        expect(subject.in_journey).to be false
      end
    end
  end


  describe "#touch in" do

    context "when oystercard has been touched in" do
      it "is true" do
        subject.top_up(50)
        subject.touch_in
        expect(subject.in_journey).to be true
      end
    end

    it "raise an error of insufficent funds" do
      expect{ subject.touch_in }.to raise_error "Insufficient balance on card"
    end
  end

  describe "#touch out" do

    context "when oystercard has been touched out" do
      it "is false" do
        subject.top_up(50)
        subject.touch_in
        subject.touch_out
        expect(subject.in_journey).to be false
      end
    end
    it "Deducts minimum fare from balance, on touch out" do
      subject.top_up(50)
      subject.touch_in
      minimum_fare = Oystercard::MINIMUM_FARE
      expect { subject.touch_out }.to change { subject.balance }.by(-minimum_fare)
    end
  end
end
