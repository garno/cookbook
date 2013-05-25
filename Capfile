default_run_options[:pty] = true
role :app, "ubuntu@peakapp"
load 'deploy' if respond_to?(:namespace)

set :deploy_to, "/opt/blog/"
set :repository, "https://garno@github.com/garno/blog.git"
set :scm, :git
set :use_sudo, false
