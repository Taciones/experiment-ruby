module Game
  class Game
    include RSpec::Matchers
    include Capybara::DSL


    #Elements
    @@accept_privacy = 'button[class=" css-1hmbpel"]'
    @@restart_game_btn =  'a[href="./"'
    @@orange_loc_1_from  = 'img[name="space42"]'
    @@orange_loc_1_to  = 'img[name="space53"]'
    @@blue_loc_1_to  = 'img[name="space24"]'
    @@orange_loc_2_from  = 'img[name="space53"]'
    @@orange_loc_2_to  = 'img[name="space64"]'



    def hit_url
      visit "https://www.gamesforthebrain.com/game/checkers/"
      sleep(2)
      find(@@accept_privacy).click

    end

    def restart_game
      find(@@restart_game_btn).click
      sleep(2)

    end

    def make_first_move
      find(@@orange_loc_1_from).click
      sleep(2)
      find(@@orange_loc_1_to).click
      sleep(2)

    end

    def make_second_move
      sleep(1)
      find(@@orange_loc_2_from).click
      sleep(1)
      find(@@orange_loc_2_to).click
      sleep(2)

    end


  end
end