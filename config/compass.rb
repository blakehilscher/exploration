project_type = :rails
http_path    = '/'
css_dir       = 'public/stylesheets'
sass_dir      = 'app/stylesheets'

# output_style = :expanded or :nested or :compact or :compressed
output_style = (environment == :production) ? :compressed : :expanded

# To enable relative paths to assets via compass helper functions.
relative_assets = true

# To disable debugging comments that display the original location of your selectors. Uncomment:
line_comments = false