# `gds_py`: a Python-only stack for Geographic Data Science

This folder contains the Python components of the `gds` Docker image. This can be accessed as part of the `gds` Docker image, or as a more lightweight image with Python-only libraries. For the latter, you can build it as:

```
docker build -t gds_py .
```

Or pull it directly from Docker Hub:

```
docker pull darribas/gds_py
```

#### To Kill an Intermediate Process/Image

```bash
docker rm -f $(docker ps -aq)
docker image ls
docker rmi <image name>
```

