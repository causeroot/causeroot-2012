server '173.236.177.241', :app, :web, :db, :primary => true
set :deploy_to, "/home/causeroot/causeroot.org"
set :branch, 'master'
set :deploy_via, :remote_cache

namespace :deploy do
  task :start do ; end
  task :stop do ; end
end
