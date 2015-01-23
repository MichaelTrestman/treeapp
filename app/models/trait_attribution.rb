class TraitAttribution < ActiveRecord::Base

  belongs_to :publication
  belongs_to :trait
  belongs_to :taxon

  def self.seed seed_hash={taxa: [], pub: nil, trait: nil}

    seed_hash[:taxa].each do |taxon|
      new_attribution = TraitAttribution.new
      new_attribution.taxon = taxon
      new_attribution.publication = seed_hash[:pub]
      new_attribution.trait = seed_hash[:trait]
      new_attribution.save
    end
  end
end