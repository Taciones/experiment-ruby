
describe 'DeckOfCards' do
  before(:all) do
    @results = my_deck.create_deck
    @parsed_results = @results.parsed_response
    @deck_id = @parsed_results["deck_id"]
    @total_cards = @parsed_results["remaining"]
    @shuffled = @parsed_results["shuffled"]

  end

  after do
    # Do nothing
  end

  context 'when condition' do

    it 'shuffles the deck' do
      my_deck.shuffle_deck(all=true,@deck_id)
      expect @shuffled.eql? true
    end

    it 'draw 3 cards' do
      new_response = my_deck.draw_x_cards(@deck_id,3)
      expect(new_response.length).eql? 3
    end

    it 'draw 10 cards and make 2 different piles from them' do
      my_deck.shuffle_deck(all=true,@deck_id)
      draw_5_cards = my_deck.draw_x_cards(@deck_id,5)
      expect(draw_5_cards.length).eql? 5
      $pile1Name = "pileone"
      pile1 = my_deck.create_pile_and_add_cards(@deck_id,$pile1Name,draw_5_cards)
      expect(pile1.response.code).eql? 200
      expect(pile1.parsed_response["remaining"]).eql?  46
      expect(pile1.parsed_response["piles"]["pileone"]["remaining"]).target.eql?  5
      draw_5_cards = my_deck.draw_x_cards(@deck_id,5)
      expect(draw_5_cards.length).eql? 5
      $pile2Name = "piletwo"
      pile2 = my_deck.create_pile_and_add_cards(@deck_id,$pile2Name,draw_5_cards)
      expect(pile2.response.code).eql? 200
      expect(pile2.parsed_response["remaining"]).eql?  41
      expect(pile2.parsed_response["piles"]["piletwo"]["remaining"]).target.eql?  5
    end

    it 'list the cards in each pile' do
      results1 = my_deck.list_cards_from_pile_x(@deck_id,$pile1Name)
      expect(results1.parsed_response["piles"][$pile2Name].size).target.eql?  1
      expect(results1.parsed_response["piles"][$pile1Name].size).target.eql?  2
      $pile1first2cards = results1.parsed_response["piles"][$pile1Name]["cards"][0]["code"], results1.parsed_response["piles"][$pile1Name]["cards"][1]["code"]
      results2 = my_deck.list_cards_from_pile_x(@deck_id,$pile2Name)
      expect(results2.parsed_response["piles"][$pile2Name].size).target.eql?  2
      expect(results2.parsed_response["piles"][$pile1Name].size).target.eql?  1
      $pile2first2cards = results2.parsed_response["piles"][$pile2Name]["cards"][0]["code"], results2.parsed_response["piles"][$pile2Name]["cards"][1]["code"]

    end

    it 'shufle pileone' do
      pile1_not_shuffled = $pile1first2cards
      my_deck.shuffle_pile_x(@deck_id,$pile1Name)
      results1 = my_deck.list_cards_from_pile_x(@deck_id,$pile1Name)
      pile1_shuffled = results1.parsed_response["piles"][$pile1Name]["cards"][0]["code"], results1.parsed_response["piles"][$pile1Name]["cards"][1]["code"]
      expect(pile1_not_shuffled == pile1_shuffled).to be false
    end

    it 'draw 2 cards from pileone' do
      response = my_deck.draw_x_cards_from_pile_x(@deck_id,$pile1Name,2)
      expect(response.parsed_response["piles"]["pileone"]["remaining"]).target.eql?  3
      expect(response.parsed_response["piles"]["piletwo"]["remaining"]).target.eql?  5
    end

    it 'draw 3 cards from piletwo' do
      response = my_deck.draw_x_cards_from_pile_x(@deck_id,$pile2Name,3)
      expect(response.parsed_response["piles"]["pileone"]["remaining"]).target.eql?  3
      expect(response.parsed_response["piles"]["piletwo"]["remaining"]).target.eql?  2

    end

  end
end
