#!/bin/bash
# vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
# Specify the image that we want to install
TARGET="jreades/gsa:2019c"
# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
wait-for-docker
echo -e "\n ******* \n\n Removing existing containers...\n"
#----
# Delete any processes from previous startup
echo -e "Running cleanup script...\n"
CID=$(docker ps -aq)
if [ -z "$CID" ]
  then
    echo -e "No docker containers found\n"
  else
    IFS=$'\n' CIDS=($CID)
    for i in "${CIDS[@]}"
    do
      RM=$(docker rm -f $i)
    done
fi
#----
# Check if we have even pulled the images!
# and pull it if we haven't.
IMGS=$(docker images "$TARGET")

# Split return from `docker images` by newline
# and discard the header output
IFS=$'\n' IIDS=($IMGS)
IIDS=("${IIDS[@]:1}")

# If we don't find an image then pull it, 
# if we do find an image then provide basic 
# information about it (useful for debugging)
if [ -z "$IIDS" ]
  then
    echo -e "=======================================\n"
    echo -e "No docker image matching $TARGET found...\n"
    echo -e ".......................................\n"
    echo -e "   Pulling $TARGET...\n"
    docker pull -q "$TARGET"
    echo -e "   Done pulling $TARGET...\n"
    echo -e "=======================================\n"
  else
    for i in "${IIDS[@]}"
    do
      echo -e "=======================================\n"
      echo -e "Found $TARGET image...\n"
      echo -e ".......................................\n"
      read VAL <<< $(echo $i | awk -F '[[:space:]][[:space:]]+' '{ printf ("%s\t%s\t%s", $3, $4, $5) }')
      IFS=$'\t' VALS=($VAL)
      echo -e "   Image ID: ${VALS[0]}\n"
      echo -e "    Created: ${VALS[1]}\n"
      echo -e "       Size: ${VALS[2]}\n"
      echo -e "=======================================\n"
    done
fi
#----
# Create mount points
mkdir -p /home/rancher/data
mount.vboxsf rancheros /home/rancher/data -o uid=1100
#----
# Start up the container
echo -e "\n ******* \n\n Starting container...\n"
docker run -p 8888:8888 \
           -p 8787:8787 \
           -p 4000:4000 \
           -d \
           --user root -e NB_UID=1100 -e NB_GID=1100 \
           -v /home/rancher:/home/jovyan/work \
           "$TARGET" \
           start.sh jupyter lab \
           --LabApp.password='sha1:7e77920661c8:d477dc309a041ded0b6822f538fc2ba8a1fb7f88'
echo -e "\n ******* \n"
echo -e "\n Container available at http://localhost:8888 \n"
echo -e "\n Please use the password 'geods' \n"
echo -e "\n ******* \n"

