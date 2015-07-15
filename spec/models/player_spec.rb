require 'rails_helper'

RSpec.describe Player, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:game) }

  describe '.generate_target' do
    context 'generates possible targets from active players' do
      it 'returns an array of possible targets and does not include inactive' do
        user = FactoryGirl.create(:user)
        user2 = FactoryGirl.create(:user)
        user3 = FactoryGirl.create(:user)
        user4 = FactoryGirl.create(:user)
        game = FactoryGirl.create(:game)
        player = Player.create(user: user, game: game)
        player2 = Player.create(user: user2, game: game)
        player3 = Player.create(user: user3, game: game)
        player4 = Player.create(user: user4, game: game, active: false)

        expect(player.generate_targets(player)).to eq [
          player2.user_id,
          player3.user_id
        ]
        expect(player.generate_targets(player)).to_not eq [
          player2.user_id,
          player3.user_id,
          player4.user_id
        ]
      end
    end
  end
end
