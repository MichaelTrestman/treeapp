class Trait < ActiveRecord::Base

  has_many :trait_attributions
  has_many :publications, through: :trait_attributions
  has_many :taxons, through: :trait_attributions

end