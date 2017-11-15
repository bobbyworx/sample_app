class Rank < ActiveRecord::Base
  validates :name, presence: true

  scope :score_overlap, ->(score_from) do
    where "((score_from <= ?) and (score_to >= ?))", score_from, score_from
  end

  validate :score_from_value
  validate :cannot_overlap_scores

  def score_from_value
    unless lower_than_score_to?
      errors.add(:score_from, 'Score from is not lower than score to')
    end
  end

  def lower_than_score_to?
    score_from < score_to
  end

  def cannot_overlap_scores
    score_overlaps = Rank.score_overlap(score_from)
    score_overlap_err unless score_overlaps.empty?
  end

  def score_overlap_err
    errors.add(:scores_overlap_err, "Scores from this rank overlaps with another's!")
  end
end
