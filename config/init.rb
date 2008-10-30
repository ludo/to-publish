# Go to http://wiki.merbivore.com/pages/init-rb

require 'config/dependencies.rb'

# If you want modules and classes from libraries organized like
# merbapp/lib/magicwand/lib/magicwand.rb to autoload,
# uncomment this.
Merb.push_path(:lib, Merb.root / "lib") # uses **/*.rb as path glob. 

use_orm :datamapper
use_test :rspec
#use_template_engine :haml

Merb::Config.use do |c|
  c[:use_mutex] = false
  c[:session_store] = 'cookie'  # can also be 'memory', 'memcache', 'container', 'datamapper
  
  # cookie session store configuration
  c[:session_secret_key]  = '1205346b9baa87cf8e49f78124c8d17a31ac0971'  # required for cookie session store
  # c[:session_id_key] = '_session_id' # cookie session id key, defaults to "_session_id"
end

Merb::BootLoader.before_app_loads do
  # This will get executed after dependencies have been loaded but before your app's classes have loaded.
  
  # MIME types
  Merb.add_mime_type(:atom, nil, %w[application/atom+xml], :charset => "utf-8")
end

Merb::BootLoader.after_app_loads do
  # This will get executed after your app's classes have been loaded.
end