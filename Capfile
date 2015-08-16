# Load DSL and set up stages
require 'capistrano/setup'

# Include default deployment tasks
require 'capistrano/deploy'

# Added by ismail
require 'capistrano/rails'
require 'capistrano/bundler'

# Include tasks from other gems included in your Gemfile
#
# For documentation on these, see for example:
#
#   https://github.com/capistrano/rvm
#   https://github.com/capistrano/rbenv
#   https://github.com/capistrano/chruby
#   https://github.com/capistrano/bundler
#   https://github.com/capistrano/rails
#   https://github.com/capistrano/passenger
#
# require 'capistrano/rvm'
# require 'capistrano/rbenv'
# require 'capistrano/chruby'
# require 'capistrano/bundler'
# require 'capistrano/rails/assets'
# require 'capistrano/rails/migrations'
# require 'capistrano/passenger'

# Load custom tasks from `lib/capistrano/tasks` if you have any defined
# load 'config/deploy/recipes/base'
# load 'config/deploy/recipes/backup'
# load 'config/deploy/recipes/check'
# load 'config/deploy/recipes/db'
# load 'config/deploy/recipes/nginx'
# load 'config/deploy/recipes/symlinks'
# load 'config/deploy/recipes/unicorn'
# load 'config/deploy/recipes/assets'
# load 'config/deploy/recipes/postgresql'
# #load 'config/deploy/recipes/whenever'
# load 'config/deploy/recipes/monit'
Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
