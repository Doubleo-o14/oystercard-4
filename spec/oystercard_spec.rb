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
    end
end
