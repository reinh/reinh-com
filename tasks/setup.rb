# $Id$

begin
  require 'webby'
rescue LoadError
  require 'rubygems'
  require 'webby'
end

SITE = Webby.site

# Webby defaults
SITE.content_dir   = 'content'
SITE.output_dir    = 'output'
SITE.layout_dir    = 'layouts'
SITE.template_dir  = 'templates'
SITE.exclude       = %w[tmp$ bak$ ~$ CVS \.svn]
  
SITE.page_defaults = {
  'layout' => 'index'
}

# Items used to deploy the webiste
SITE.host       = 'www@reinh.com'
SITE.remote_dir = '/var/www/beta.reinh.com'
SITE.rsync_args = %w(-av --delete)

# Options passed to the 'tidy' program when the tidy filter is used
SITE.tidy_options = '-indent -wrap 80'

# Load the other rake files in the tasks folder
Dir.glob('tasks/*.rake').sort.each {|fn| import fn}

# EOF
