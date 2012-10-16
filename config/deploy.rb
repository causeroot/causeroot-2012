require 'bundler/capistrano'

set :application, "causeroot"

set :scm, :git
set :repository, "https://github.com/gardner/CauseRoot.git"

ssh_options[:keys] = %w(~/.ssh/id_rsa)
ssh_options[:port] = 443

set :user, 'deploy'
set :domain, 'causeroot.org'
set :deploy_to, "/home/#{user}/#{application}/"
set :applicationdir, "appdir"
set :port, 443
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
	
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
  task :finalize_update do
		run "ln -nfs #{deploy_to}/shared/config/database.yml #{release_path}/config/database.yml"
	end  
end
