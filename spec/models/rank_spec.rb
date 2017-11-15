require 'rails_helper'

RSpec.describe Rank, type: :model do

  describe 'rank' do
    subject { build(:rank) }
    it { should validate_presence_of(:name) }
    it { should validate_numericality_of(:score_from) }
    it { should validate_numericality_of(:score_to) }
  end

  describe 'ranks attrs' do
    it 'checks if score_from is less than score_to' do
      rank = Rank.create(score_from: 2.4, score_to: 5.2, name: 'example rank' )
      expect(rank.send(:lower_than_score_to?)).to eq true
    end

    it 'checks if score_to is higher than score_from' do
      rank = Rank.create(score_from: 2.4, score_to: 5.2, name: 'example rank' )
      expect(rank.send(:higher_than_score_from?)).to eq true
    end

    it 'checks for overlaping rank scores' do
      rank_one = Rank.create(score_from: 2.4, score_to: 5.2, name: 'example rank' )
      rank_two = Rank.create(score_from: 4.0, score_to: 8, name: 'example rank two' )

      expect(Rank.score_overlap(rank_two.score_from).size).to eq 1
      expect(rank_two.send(:score_overlap_err).first).to include('overlaps with')
    end
  end

end
