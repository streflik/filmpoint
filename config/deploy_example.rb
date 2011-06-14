set :application, "filmpoint"

default_run_options[:pty] = true  # Must be set for the password prompt from git to work
set :repository, "git://github.com/streflik/filmpoint.git"  # Your clone URL
set :scm, "git"
set :user, "eventio"  # The server's user for deploys
set :scm_passphrase, "lalla"  # The deploy user's password
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`
ssh_options[:forward_agent] = true
set :branch, "master"
set :deploy_via, :remote_cache
set :deploy_to, "/home/eventio/www/"

server "eventio.megiteam.pl", :app, :web, :db, :primary => true
set :use_sudo, false
# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
   task :restart, :roles => :app do
     run "restart-app filmpoint"
   end
end