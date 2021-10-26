require 'oystercard'
describe Oystercard do
    it "shows yourt balance" do
        card = Oystercard.new
        expect(card.balance).to eq(0)
    end
    describe '#top_up' do
      it "tops your card up" do
        expect(subject).to respond_to(:top_up).with(1).argument
      end
      it "raise error at maximum limit" do
        max = subject.MAX_BALANCE
        subject.top_up(max)
        expect{ subject.top_up(1) }.to raise_error("cannot top up anymore, at maximum limit.")
      end
    end
end
