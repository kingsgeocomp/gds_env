# Ubuntu Bionic 18.04 at Aug'19
FROM darribas/gds_py:3.0

MAINTAINER Jon Reades <jonathan.reades@kcl.ac.uk>

# Add the same code as for gsa_py Dockerfile.
# Could be moved to a requirements.txt file and 
# then called from both Dockerfiles.

# To push 
# docker tag <IMAGE ID> jreades/gsa:1.0
# docker push jreades/gsa:1.0 
