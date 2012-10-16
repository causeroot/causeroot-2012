require 'bundler/capistrano'
require "rvm/capistrano"

set :stages, %w(production staging)
set :default_stage, "staging"
require 'capistrano/ext/multistage'

set :application, "capistrano-multistage-test"
set :user, "www-data"
set :group, "www-data"

set :scm, :git
set :repository, "ssh://ourserver/#{application}.git"
set :deploy_to, "/var/www/#{application}"
set :deploy_via, :remote_cache
set :rails_env, 'production'
set :rvm_type, :system  # Copy the exact line. I really mean :system here

set :application, "causeroot"

set :scm, :git
set :repository, "https://github.com/gardner/CauseRoot.git"
set :scm_password, ""

set :user, 'ubuntu'
set :domain, 'causeroot.org'
set :deploy_to, "/home/#{user}/#{application}/"
set :applicationdir, "appdir"
set :port, 22
set :use_sudo, false

role :web, domain
role :app, domain
role :db,  domain, :primary => true # This is where Rails migrations will run

# if you want to clean up old releases on each deploy uncomment this:
after "deploy:restart", "deploy:cleanup"

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
	task :before_update_code do
		#stop solr:
		run "cd #{current_path} && rake sunspot:solr:stop RAILS_ENV=#{rails_env}"
	end
	
	after "deploy:update_crontab", "deploy:solr:symlink"

	namespace :solr do
			desc <<-DESC
				Symlink in-progress deployment to a shared Solr index.
			DESC
			task :symlink, :except => { :no_release => true } do
			run "ln -nfs #{shared_path}/solr #{current_path}/solr"
			run "ls -al #{current_path}/solr/pids/"
			run "cd #{current_path} && rake sunspot:solr:start RAILS_ENV=#{rails_env}"
		end
	end
	
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
  task :finalize_update do
		run "ln -nfs #{deploy_to}shared/config/database.yml #{release_path}/config/database.yml"
	end  
end


