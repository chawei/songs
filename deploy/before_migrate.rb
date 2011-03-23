app = "songs"

if %x[ps axo command|grep resque[-]|grep -c Forked].to_i > 0 
  raise "Resque Workers Working!!"
else
  run "sudo monit stop all -g #{app}_resque"
end

run "ln -nfs #{shared_path}/config/sphinx #{release_path}/config/sphinx"
run "ln -nfs #{shared_path}/config/sphinx.yml #{release_path}/config/sphinx.yml"
run "ln -nfs #{shared_path}/config/s3.yml #{release_path}/config/s3.yml"
run "ln -nfs #{shared_path}/config/resque.yml #{release_path}/config/resque.yml"