app = "songs"

run "monit restart all -g #{app}_resque"