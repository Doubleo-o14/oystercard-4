require './lib/oystercard'

describe Oystercard do
  let(:station) { double :station }
  let(:journey) { {:journey_entry => :station, :journey_exit => :station} }

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

  describe '#in_journey?' do
    
    context "when oystercard is initalized it" do
      it "is false" do
        expect(subject.in_journey?).to be false
      end
    end

    context "when oystercard has been touched in" do
      it "is true" do
        subject.top_up(50)
        subject.touch_in(:station)
        expect(subject.in_journey?).to be true
      end
    end

    context "when oystercard has been touched out" do
      it "is false" do
        subject.top_up(50)
        subject.touch_in(:station)
        subject.touch_out(:station)
        expect(subject.in_journey?).to be false
      end
    end
    
  end

  describe "#touch in" do

    it "raise an error of insufficent funds" do
      expect{ subject.touch_in(:station) }.to raise_error "Insufficient balance on card"
    end

    it 'registers an entry_station on touch_in' do
      subject.top_up(50)
      subject.touch_in(:station)
      expect(subject.entry_station).to eq :station
    end
  end

  describe "#touch out" do

    it "Deducts minimum fare from balance, on touch out" do
      subject.top_up(50)
      subject.touch_in(:station)
      minimum_fare = Oystercard::MINIMUM_FARE
      expect { subject.touch_out(:station) }.to change { subject.balance }.by(-minimum_fare)
    end

    it 'reset entry_station to nil' do
      subject.top_up(50)
      subject.touch_in(:station)
      subject.touch_out(:station)
      expect(subject.entry_station).to eq nil
    end

    it 'registers an exit_station on touch_out' do
      subject.top_up(50)
      subject.touch_in(:station)
      subject.touch_out(:station)
      expect(subject.exit_station).to eq :station
    end

    it 'adds the journey with entry_station and exit_station as a hash to @journey_history' do
      subject.top_up(50)
      subject.touch_in(:station)
      subject.touch_out(:station)
      expect(subject.journey_history).to include journey
    end
  end
  
  describe "#journey_history" do
    it "expects there not to be a journey history on initialization" do
      expect(subject.journey_history).to be_empty
    end
  end 
end
