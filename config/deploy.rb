# For more information on config variables that come with the default
# deploy recipe, see https://github.com/capistrano/capistrano/blob/master/lib/capistrano/recipes/deploy.rb

################################################################################
# Load 3rd party rake tasks
################################################################################

# Automatically update the crontab with Whenever tasks
# the appropriate point in the deploy sequence.
require "whenever/capistrano"
set :whenever_command, "bundle exec whenever"
set :whenever_roles, :app

# Automatically run 'bundle install' on the remote server
# with deployment-friendly options.
require "bundler/capistrano"

# Allocate a pseudo-tty for each command. Allows interactive commands
# to prompt for input.
default_run_options[:pty] = true

################################################################################
# Configure application
################################################################################
set :application, "carrio"
server "foobar.com", :web, :app, :db, :primary => true
set :deploy_to, "/home/carrio_org/carrio.org"
set :rails_env, "production"
set :migrate_target, :current
set :keep_releases, 5
set :deploy_via, :remote_cache
set :production_database, "carrio_production"

################################################################################
# Configure source control
################################################################################
set :scm, :git
set :repository,  "git@github.com:gardner/carrio.git"
set :git_enable_submodules, 1

################################################################################
# Set deploy user
################################################################################
set :user, "deploy"
set :use_sudo, false

################################################################################
# Before and after hooks
################################################################################

# Delete old deployments of the app to
# save disk space.
after [:deploy, "deploy:clean"], "deploy:cleanup"

# Ensure we are deploying a named branch or tag
before "deploy:update_code" do
  set :branch, (ENV['BRANCH'] or ENV['TAG'])
  if not fetch(:branch)
    $stderr.puts "You must supply either a TAG or BRANCH"
    exit 1
  end
end

def rake_task(name)
  run "cd #{current_path}; RAILS_ENV=#{rails_env} bundle exec rake #{name}"
end

namespace :deploy do
  task :start do
    deploy.restart
  end

  # Capistrano will call this whenever it needs to 'restart' our app
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

# Override default deploy task with more reasonable behavior
namespace :deploy do
  desc <<-DESC
    Deploy the code and run pending migrations. Pending migrations are \
    run via the `deploy:migrate' task prior to updating the symlink. \
    Note that the update in this case is not atomic, and transactions are not used, \
    because migrations are not guaranteed to be reversible.
  DESC
  task :default do
    migrations
  end

  desc <<-DESC
    Deploys and starts a `cold' application. This is useful if you have not \
    deployed your application before, or if your application is (for some \
    other reason) not currently running. It will deploy the code, run any \
    pending migrations, then invoke `deploy:start' to fire up the application servers.
  DESC
  task :cold do
    setup
    update
    rake_task('db:setup')
    start
  end
end
