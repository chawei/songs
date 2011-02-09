namespace :sphinx do
  desc "Stop the sphinx server"
  task :stop, :roles => [:app], :only => {:sphinx => true} do
    run "cd #{latest_release} && RAILS_ENV=#{rails_env} rake thinking_sphinx:stop"
  end

  desc "Reindex the sphinx server"
  task :index, :roles => [:app], :only => {:sphinx => true} do
    run "cd #{latest_release} && RAILS_ENV=#{rails_env} rake thinking_sphinx:index"
  end

  desc "Configure the sphinx server"
  task :configure, :roles => [:app], :only => {:sphinx => true} do
    run "cd #{latest_release} && RAILS_ENV=#{rails_env} rake thinking_sphinx:configure"
  end

  desc "Start the sphinx server"
  task :start, :roles => [:app], :only => {:sphinx => true} do
    run "cd #{latest_release} && RAILS_ENV=#{rails_env} rake thinking_sphinx:start"
  end

  desc "Restart the sphinx server"
  task :restart, :roles => [:app], :only => {:sphinx => true} do
    run "cd #{latest_release} && RAILS_ENV=#{rails_env} rake thinking_sphinx:running_start"
  end
end