class Rank < ActiveRecord::Base

  validate :score_from_value
  validate :score_to_value
  validate :cannot_overlap_scores
  validates_numericality_of :score_from, :score_to, with: /\A[0-9]+\.[0-9]{1}\z/
  validates :name, presence: true

  scope :score_overlap, ->(score_from) do
    where "((score_from <= ?) and (score_to >= ?))", score_from, score_from
  end

  private

  def score_from_value
    unless lower_than_score_to?
      errors.add(:score_from, 'Score from is not lower than score to')
    end
  end

  def lower_than_score_to?
    score_from < score_to
  end

  def score_to_value
    unless higher_than_score_from?
      errors.add(:score_to, 'Score to is not higher than score to')
    end
  end

  def higher_than_score_from?
    score_to > score_from
  end

  def cannot_overlap_scores
    score_overlap_err unless Rank.score_overlap(score_from).empty?
  end

  def score_overlap_err
    errors.add(:scores_overlap_err, "Scores from this rank overlaps with another's!")
  end
end
