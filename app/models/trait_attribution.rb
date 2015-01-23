class TraitAttribution < ActiveRecord::Base

  belongs_to :publication
  belongs_to :trait
  belongs_to :taxon

end