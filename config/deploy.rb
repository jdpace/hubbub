set :application, "cltruby"
set :user, "cltruby"
set :domain, "#{user}@solidstack.com"
set :deploy_to, "/home/#{user}/apps/#{application}"
set :repository, "git://github.com/jroes/hubbub.git"

namespace :vlad do
  task :deploy => ['vlad:update', 'vlad:migrate', 'vlad:start_app']

  remote_task :update do
    run "cp /home/#{user}/configs/#{application}/database.yml #{current_path}/config/"
  end
end
