# BlackArch docker image

The motivation behind this image was to have a container where it would be safe to execute potentially malicious executables while keeping all your best hacking tools at hand and all of this without making a mess on your day-to-day environment.

## Build

Very simple : `make docker-image`

The `sydpy/blackarch` image produced will be based on the ArchLinux image with BlackArch installed on top via its strap.sh script (see [here](https://www.blackarch.org/downloads.html#install-repo)). Every BlackArch tool is included in the image as a `pacman -S blackarch` is performed during the build process, however it makes this process quite long so don't do it on a daily basis.

For now, after downloading the strap.sh script, no sha1sum verification is done.

## Run

As every container : `docker run -it sydpy/blackarch /bin/bash` if you want to get an interactive Bash shell.

Read [Docker run reference](https://docs.docker.com/engine/reference/run/) for more documentation about... well... Docker run.

