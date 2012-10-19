server '184.72.47.189', :app, :web, :db, :primary => true
set :deploy_to, "/home/ubuntu/staging/#{application}/"
set :branch, 'develop'
set :rails_env, 'production'
set :deploy_via, :remote_cache

namespace :deploy do
  task :start do ; end
  task :stop do ; end

  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
  task :finalize_update do
		run "ln -nfs #{deploy_to}shared/config/database.yml #{release_path}/config/database.yml"
	end 
end