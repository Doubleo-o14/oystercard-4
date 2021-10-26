require 'oystercard'
describe Oystercard do
    it "shows yourt balance" do
        card = Oystercard.new
        expect(card.balance).to eq(0)
    end
end
