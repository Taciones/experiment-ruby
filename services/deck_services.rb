module Deck
  class Deck
    include HTTParty

    #base_uri CONFIG_API['deck_uri']
    #base_uri("https://deckofcardsapi.com/api/deck/")
    base_uri("https://deckofcardsapi.com/api/deck")


    def create_deck
      self.class.post("/new/", headers: {'Content-Type': 'application/json'})
    end


    def create_deck_with_x_decks(number_decks)
      self.class.post("/new/shuffle/?deck_count=#{number_decks}", headers: {'Content-Type': 'application/json'})
    end

    def draw_x_cards(deck_id,cards_num)
      #this part of API is broken, so I added the loops here.
      counter = 0
      cards = []
      while counter <= cards_num do
        response = self.class.post( "/#{deck_id}/draw/?count=#{cards_num}", headers: {'Content-Type': 'application/json'})
        card = response.parsed_response["cards"]
        cards << card
        counter += 1
      end
      cards_drawed = []
      cards.pop()
      while cards.length() > 0 do
        popped0 = cards.pop()
        popped1 = popped0.pop()
        cards_drawed << popped1["code"]
      end

      return cards_drawed

    end

    def shuffle_deck(all=false,id)
      if all
        self.class.post("/#{id}/shuffle/")
      else
        self.class.post("#{id}/shuffle/?remaining=true")
      end
    end

    def create_pile_and_add_cards(deck_id,pile_name,cards)
      cards_text = cards.join(",")
      self.class.get("/#{deck_id}/pile/#{pile_name}/add/?cards=#{cards_text}")
    end

    def list_cards_from_pile_x(deck_id,pile_name)
      self.class.get("/#{deck_id}/pile/#{pile_name}/list/", headers: {'Content-Type': 'application/json'})
    end

    def shuffle_pile_x(deck_id,pile_name)
      self.class.get("/#{deck_id}/pile/#{pile_name}/shuffle/", headers: {'Content-Type': 'application/json'})
    end

    def draw_x_cards_from_pile_x(deck_id,pile_name,card_num)
      self.class.get("/#{deck_id}/pile/#{pile_name}/draw/?count=#{card_num}", headers: {'Content-Type': 'application/json'})

    end

  end
end