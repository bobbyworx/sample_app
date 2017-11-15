require 'rails_helper'

RSpec.describe Rank, type: :model do

  describe 'rank' do
    it { should validate_presence_of(:name) }
  end

  describe 'ranks attrs' do
    it 'checks if score_from is less than score_to' do
      rank = Rank.new(score_from: 2.4, score_to: 5.2, name: 'example rank' )
      expect(rank.score_to).to be > rank.score_from
    end
  end

end
