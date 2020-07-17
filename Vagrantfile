Vagrant.configure("2") do |config|
  config.vm.box = "ailispaw/barge"
  # May want to add `, host_ip: "127.0.0.1"` to below lines for security
  config.vm.network "forwarded_port", guest: 8888, host: 8888, auto_correct: true
  config.vm.network "forwarded_port", guest: 8787, host: 8787
  config.vm.network "forwarded_port", guest: 4000, host: 4000
  config.vm.synced_folder "./notebooks/", "/home/vagrant/notebooks", create: true, docker_consistency: "delegated"

  config.vm.provider "virtualbox" do |vb|
    # Set name
    vb.name = "gsa2020"

    # Display the VirtualBox GUI when booting the machine
    vb.gui = false

    # Customize the amount of memory on the VM:
    vb.memory = 4096
    vb.cpus = 2
  end

  # Docker pull image (only run once or 
  # on reprovisioning)
  config.vm.provision "docker" do |d|
    d.pull_images "jreades/gsa:2020"
  end

  # RESTARTING DOCKER
  # **************************************************
  # Option 1: A persistent container that will restart
  # automatically every time you launch vagrant. So if
  # you are ok with a persistent container (which you 
  # might well be if you aren't worried about hosing 
  # your docker-provided app) then Option 1 is faster 
  # and easier on reboot. 
  #
  #config.vm.provision "docker" do |d|
  #  d.pull_images "jreades/gsa:2020"
  #  d.run "jupyter",
  #   image: "jreades/gsa:2020",
  #   args: "-v '/home/vagrant/notebooks:/home/jovyan/' \
  #          -p 8888:8888 \
  #          -p 8787:8787 \
  #          -p 4000:4000 \
  #          ",
  #   daemonize: true,
  #   restart: "no",
  #end
  #
  #config.vm.provision "shell", inline: "docker restart $(docker ps -a -q)",
  #  run: "always"
  #
  # **************************************************
  # Option 2: We want to remove any existing containers 
  # *every single time* so that no changes to the conatainer
  # are ever saved. This is probably better for teaching since
  # you can be guaranteed that no one will have pip-installed 
  # something or otherwise modified the container.
  #
  config.vm.provision "shell", run: "always", inline: <<-SCRIPT
	printf "Running cleanup script...\n"

	# Capture existing containers
	CID=$(docker ps -aq)

	# Check if we have any
	if [ -z "$CID" ]
	then
          # If not, that's fine but we can say so
          printf "No docker containers found...\n"
	else
          # we've found some
          printf "Found docker containers...\n"

          # Parse the container IDs into an array --
          # although unlikely, it's possible that more
          # than one container has been set up.
          IFS=$'\n' CIDS=($CID)

          # For each container ID
          for i in "${CIDS[@]}"
          do
            # Let the user know what we're up to
            printf "  Stopping and removing container id: ${i}\n"

            # Capture the output
            STOP=$(docker stop $i)
            RM=$(docker rm $i)
            if [ "$STOP" != "$i" ];
            then
              # Something has gone wrong
              printf "Unexpected output from docker stop: $STOP\n"
            fi
            if [ "$RM" != "$i" ];
            then
              # Something has gone wrong
              printf "Unexpected otuput from docker rm: $RM\n"
            fi
          done
	fi

	printf "Done.\n"
SCRIPT

  config.vm.provision "shell", run: "always", inline: <<-SCRIPT
	printf "Running docker start-up script...\n"

	docker run -d --name jupyter \
          -v '/home/vagrant/notebooks:/home/jovyan/' \
          -p 8888:8888 \
          -p 8787:8787 \
          -p 4000:4000 \
          jreades/gsa:2020 \
	  start.sh jupyter lab \
	  --LabApp.password='sha1:3b9653503d8e:552e78e8443a239b355c0f121ab905517f8492fe'
	printf "Done.\n"
SCRIPT

end
