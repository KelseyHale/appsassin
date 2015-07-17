class RoundAssignment < ActiveRecord::Base
  belongs_to :round
  belongs_to :player
  belongs_to :target

  validates_associated :round
  validates_associated :player
  validates_associated :target
end
