require 'bundler/capistrano'

set :user, 'deploy'
set :domain, 'carrio.org'
set :applicationdir, "appdir"
set :port, 443

set :application, "carrio"
set :scm, :git
set :repository,  "https://github.com/gardner/carrio.git"
set :deploy_via, :checkout
set :use_sudo, false
set :scm_verbose, true
set :deploy_to, "/home/deploy/carrio"


# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, domain                          # Your HTTP server, Apache/etc
role :app, domain                          # This may be the same as your `Web` server
role :db,  domain, :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"

set :rails_env, "production"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
		run "ln -nfs #{deploy_to}/shared/config/database.yml #{release_path}/config/database.yml"
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

# if you want to clean up old releases on each deploy uncomment this:
after "deploy:restart", "deploy:cleanup"
