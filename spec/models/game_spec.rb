require 'rails_helper'

RSpec.describe Game, type: :model do
  it { should belong_to(:user) }
  it { should validate_presence_of(:name) }

  describe '.player_in_game?' do
    context 'player is in game' do
      it 'return true' do
        user = FactoryGirl.create(:user)
        game = FactoryGirl.create(:game)
        Player.create(user: user, game: game)
        expect(game.player_in_game?(game, user)).to eq true
      end
    end
    context 'player is not in game' do
      it 'return false' do
        user = FactoryGirl.create(:user)
        game = FactoryGirl.create(:game)
        expect(game.player_in_game?(game, user)).to eq false
      end
    end
  end
end
