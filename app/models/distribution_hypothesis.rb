class DistributionHypothesis < ActiveRecord::Base

  has_many :dh_claims
  has_many :publications
  has_many
  has_many :taxons

end