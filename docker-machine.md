# RancherOS and Docker Machine

See Dani's page on this, but key references:
- https://rancher.com/docs/os/v1.x/en/quick-start-guide/
- https://rancher.com/docs/os/v1.x/en/
- https://rancher.com/docs/os/v1.x/en/configuration/write-files/
- https://rancher.com/docs/os/v1.x/en/configuration/running-commands/
- https://rancher.com/docs/os/v1.x/en/configuration/sysctl/
- https://rancher.com/docs/os/v1.x/en/system-services/

Copy the cloud-config into the new system:
docker-machine scp ~/Desktop/cloud-config.yml gsa2020:

Then login via ssh:
docker-machine ssh gsa2020 -t

Then append your cloud-config.yml to the base cloud-config.yml file:
sudo sh -c 'cat "/home/docker/cloud-config.yml" >> /var/lib/rancher/conf/cloud-config.yml'

Then restart!
