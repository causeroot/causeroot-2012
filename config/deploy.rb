require 'bundler/capistrano'

set :application, "cause-root"

set :scm, :none
set :repository, "."
set :deploy_via, :copy

set :domain, "netacus.net"
set :user, "netacusnet"
set :deploy_to, "/home/#{user}/#{application}/"
set :use_sudo, false

role :web, domain
role :app, domain
role :db,  domain, :primary => true # This is where Rails migrations will run

# if you want to clean up old releases on each deploy uncomment this:
after "deploy:restart", "deploy:cleanup"

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end
