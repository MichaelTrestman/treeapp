# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )

Rails.application.config.assets.precompile += %w( d3.v3.js )
Rails.application.config.assets.precompile += %w( treeData.js trait-mapping.js force3.js trait-map-switcher.js view-pan.js)

