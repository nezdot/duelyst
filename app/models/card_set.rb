class CardSet < ApplicationRecord
  has_many :cards

  RARITY_WEIGHTS = {
    common: 60,
    rare: 25,
    epic: 10,
    legendary: 5
  }

  def self.open_orb
    total_weight = RARITY_WEIGHTS.values.sum
    random_number = rand(total_weight)
    
    cumulative_weight = 0
    chosen_rarity = RARITY_WEIGHTS.find do |rarity, weight|
      cumulative_weight += weight
      random_number < cumulative_weight
    end.first

    Card.where(rarity: chosen_rarity).sample
  end
end