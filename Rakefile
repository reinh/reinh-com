# $Id$

load 'tasks/setup.rb'

task :default => :build

desc 'depoloy the site to the webserver'
task :deploy => [:build, 'deploy:rsync']

# EOF
