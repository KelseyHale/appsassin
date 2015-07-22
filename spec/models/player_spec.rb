require 'rails_helper'

RSpec.describe Player, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:game) }

  describe '.target' do
    context 'a player as an assigned target' do
      it 'returns the name of the target' do
        user = FactoryGirl.create(:user)
        user2 = FactoryGirl.create(:user)
        game = FactoryGirl.create(:game)
        player1 = Player.create!(user: user, game: game)
        Player.create!(user: user2, game: game)
        Target.create!(user: user, game: game)
        target2 = Target.create!(user: user2, game: game)
        Round.create!(name: 1, game: game)
        Round.assign_targets_to_actives(game)
        expect(player1.target).to eq target2
      end
    end
  end
end
