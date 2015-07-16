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
        user5 = FactoryGirl.create(:user)
        game = FactoryGirl.create(:game)
        game2 = FactoryGirl.create(:game)
        player = Player.create(user: user, game: game)
        player2 = Player.create(user: user2, game: game)
        player3 = Player.create(user: user3, game: game)
        player4 = Player.create(user: user4, game: game, active: false)
        player5 = Player.create(user: user3, game: game2)
        target = Target.create(user: user, game: game)
        target2 = Target.create(user: user2, game: game)
        target3 = Target.create(user: user3, game: game)
        target4 = Target.create(user: user4, game: game, active: false)
        target4 = Target.create(user: user4, game: game2)

        expect(player.generate_targets(player)).to eq [
          target2,
          target3
        ]
        expect(player.generate_targets(player)).to_not eq [
          target2,
          target3,
          target4
        ]
      end
    end
    # context --- need to test assign_target_to_player --- test for random??
  end
end
