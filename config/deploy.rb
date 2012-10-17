require 'bundler/capistrano'
require "rvm/capistrano"

set :application, "causeroot"

set :user, 'ubuntu'
set :domain, 'causeroot.org'
set :deploy_to, "/home/#{user}/#{application}/"
set :applicationdir, "appdir"
set :port, 22
set :use_sudo, false

set :scm, :git
set :repository, "https://github.com/gardner/CauseRoot.git"
set :scm_password, ""


task :production do
	set :rails_env, 'production'
	set :rvm_type, :system  # Copy the exact line. I really mean :system here
	
  role :web, "causeroot.org", :primary => true
  set :deploy_to, "/u/apps/#{application}-production/"
  set :deploy_via, :remote_cache
  after('deploy:symlink', 'cache:clear')
end

task :staging do
	set :rails_env, 'staging'
  role :web, "beta.causeroot.org", :primary => true
  set :deploy_to, "/Users/capistrano/Sites/#{application}-staging/"
  set :deploy_via, :copy
  after('deploy:symlink', 'cruise_control:build')
end

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


