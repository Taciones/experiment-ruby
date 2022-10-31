

describe 'GameActions' do
  before  do
    gameactions.hit_url
  end

  after do
    # Do nothing
  end

  context 'faking game user actions' do
    it 'restarting game' do
      gameactions.restart_game
      expect(page).to have_content 'Checkers'
      expect(page).to have_content 'Select an orange piece to move.'
    end

    it 'making action on the game' do
      gameactions.make_first_move

      gameactions.make_second_move

      gameactions.restart_game

    end
  end
end
