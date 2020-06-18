#! /bin/bash -e

printf "Running gettoken file\n"

# Capture existing containers
CID=$(docker ps -aq)

# Check if we have any
if [ -z "$CID" ]
then
        # If not, that's fine but we can say so
        printf "No running docker containers...\n"
else
        # we've found some
        printf "Looking for tokens on running containers...\n"
        # Parse the container IDs into an array --
        # although unlikely, it's possible more than
        # one is running.
        IFS=$'\n' CIDS=($CID)

        for i in "${CIDS[@]}"
        do
                printf "Container id: $i\n"
		echo $(docker exec -i $i jupyter notebook list)
		TOKEN=$(echo $(docker exec -i $i sh -c "jupyter notebook list") | sed -nE 's/.*=([0-9A-Fa-f]+).*/\\1/p')
                printf "\thas token ${TOKEN}\n"
        done
fi

printf "Done.\n"
