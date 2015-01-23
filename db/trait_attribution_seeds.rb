
trait_attributions_to_seed = [


  {
    taxa: [
      Taxon.create({

        })
      ],
    pub: Publication.where('')
  }












]















# pub = Publication.where("title ILIKE '%the cambrian explosion and the origins of embodied cognition%'" ).first

# verts = Taxon.create({common_name: 'Vertebrates'})
# arthropods = Taxon.create({common_name: 'Arthropods'})
# mollusks = Taxon.create({common_name: 'Mollusks'})

# trait = Trait.create({name: "Basic cognitive embodiment"})

# attribution1 = TraitAttribution.new
# attribution1.publication = pub
# attribution1.trait = trait
# attribution1.taxon = verts

# attribution2 = TraitAttribution.new
# attribution2.publication = pub
# attribution2.trait = trait
# attribution2.taxon = arthropods

# attribution3 = TraitAttribution.new
# attribution3.publication = pub
# attribution3.trait = trait
# attribution3.taxon = mollusks

# [attribution1, attribution2, attribution3].each{ |x| x.save }


# def seed_trait_attribution seed_hash={taxa: [], pub: nil, trait: nil}
#   seed_hash[:taxa].each do |taxon|
#     new_attribution = TraitAttribution.new
#     new_attribution.taxon = taxon
#     new_attribution.publication = seed_hash[:pub]
#     new_attribution.trait = seed_hash[:trait]
#     new_attribution.save
#   end
# end








