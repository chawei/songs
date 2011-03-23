app = "songs"

run "sudo monit restart all -g #{app}_resque"