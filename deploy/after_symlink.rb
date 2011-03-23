app = "song"

run "monit restart all -g #{app}_resque"