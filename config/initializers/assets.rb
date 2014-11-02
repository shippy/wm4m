# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

Rails.application.config.assets.precompile += %w( dashboard.js)

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )

initializer 'setup_asset_pipeline', :group => :all  do |app|
  # We don't want the default of everything that isn't js or css, because it pulls too many things in
  app.config.assets.precompile.shift

  # Explicitly register the extensions we are interested in compiling
  app.config.assets.precompile.push(Proc.new do |path|
    File.extname(path).in? [
      '.html', '.erb', '.haml',                 # Templates
      '.png',  '.gif', '.jpg', '.jpeg',         # Images
      '.eot',  '.otf', '.svc', '.woff', '.ttf', # Fonts
    ]
  end)
end
