dependency "merb-action-args"    # Provides support for querystring arguments to be passed in to controller actions
dependency "merb-assets"         # Provides link_to, asset_path, auto_link, image_tag methods (and lots more)
dependency "merb-cache"          # Provides your application with caching functions 
dependency "merb-helpers"        # Provides the form, date/time, and other helpers
#dependency "merb-mailer"        # Integrates mail support via Merb Mailer
#dependency "merb-slices"        # Provides a mechanism for letting plugins provide controllers, views, etc. to your app
#dependency "merb-auth"          # An authentication slice (Merb's equivalent to Rails' restful authentication)
 
dependency "dm-core"            # The datamapper ORM
dependency "dm-aggregates"      # Provides your DM models with count, sum, avg, min, max, etc.
#dependency "dm-migrations"      # Make incremental changes to your database.
#dependency "dm-sweatshop"       # Generate pseudorandom models for testing or populating your development database
dependency "dm-timestamps"      # Automatically populate created_at, created_on, etc. when those properties are present.
#dependency "dm-types"           # Provides additional types, including csv, json, yaml.
dependency "dm-validations"     # Validation framework

dependency "RedCloth", "> 4.0"