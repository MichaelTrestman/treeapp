class Taxon < ActiveRecord::Base
  serialize :link_urls, Array

  has_many :trait_attributions
  has_many :traits, through: :trait_attributions
  has_many :publications, through: :trait_attributions
  has_many :subtaxons, class_name: 'Taxon', foreign_key: 'supertaxon_id'
  belongs_to :supertaxon, class_name: 'Taxon'

  def add_subtaxon(subTaxonAttributes)
    subTaxonAttributes[:supertaxon_id] = self.id
    subTaxon = Taxon.create(subTaxonAttributes)
    # self.subtaxons << subTaxon
    # subTaxon.supertaxon = self
  end


end