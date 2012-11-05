require 'bundler/capistrano'
require "rvm/capistrano"
require 'capistrano/ext/multistage'

set :rvm_type, :system  # Copy the exact line. I really mean :system here

set :stages, %w(production staging)
set :default_stage, "staging"

set :application, "causeroot"

set :keep_releases, 1

set :scm, :git
set :user, 'ubuntu'
set :use_sudo, false
ssh_options[:keys] = %w(~/.ssh/id_dsa ~/.ssh/id_rsa '~/.ssh/openplaya.pem')
set :repository, "https://github.com/gardner/CauseRoot.git"
set :deploy_to, "/home/ubuntu/#{application}"
set :deploy_via, :remote_cache
set :rails_env, 'production'

task :uname do
  run "uname -a"
end

