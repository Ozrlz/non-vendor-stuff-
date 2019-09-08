# This is a simple line that executes an interactive process (mostly an [ba]sh process)

This is useful in case you have a bunch processess you would like to execute interactively to different containers, in which case you piped an output to xargs. In a simple way, your docker 
container exec command will not work since the xargs behavior is to run each iteration on a child process and redirects its stdin to /dev/null, so you won't be 
able to connect stdio of the child process to the current terminal process (your current [ba/z]sh process.

