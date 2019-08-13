# `gsa_env`: A stripped down Python platform for Geographic Data Science

# DOES NOT YET WORK! 

Am in the process of updating from Dani's work to remove R and TeX as we don't need these for teaching but do have a few more Python packages that we _do_ use.

[![](https://images.microbadger.com/badges/image/darribas/gds:3.0.svg)](https://microbadger.com/images/darribas/gds:3.0 "Get your own image badge on microbadger.com")
[![](https://images.microbadger.com/badges/version/darribas/gds:3.0.svg)](https://microbadger.com/images/darribas/gds:3.0 "Get your own version badge on microbadger.com")

This repository contains a `docker` container that includes:

* A full Python stack ready for geospatial analysis (see `gds_stack.yml` for a detailed list).
* Additional development utilities (e.g. `pandoc`, `git`, `decktape`, etc.).

## Requirements

You will need [Docker](https://www.docker.com) to be able to install the GDS environment.

## Installing

You can install this container by simply running:

> `docker pull jreades/gsa:1.0`

[Note that you'll need [Docker](https://www.docker.com) installed on your machine]

## Building

If, instead, you want to build from source, the Docker image can be built by running:

> `docker build -t jreades/gsa:1.0 .`

You can check it has been built correctly by:

> `docker image ls`

And you should see one image with the name `gsa`.

## Running

The container can be run as:

```
> docker run --rm -ti -p 8888:8888 -v ${pwd}:/home/jovyan/host darribas/gas:1.0
```

<img src="JupyterLab.png" width="500">

A couple of notes on the command above:

* This opens the `8888` port of the container, so to access the Lab instance,
  you will have to point your browser to `localhost:8888` and insert the token
  printed on the terminal
* The command also mounts the current folder (`pwd`) to the container, but you can replace that with the path to any folder on your local machine (in fact, that will only work on host machines with the `pwd` command installed)

## Citing

This draws heavily on Dani Arribas-Bel's work for Liverpool. If you use this, you should cite him.

[![DOI](https://zenodo.org/badge/65582539.svg)](https://zenodo.org/badge/latestdoi/65582539)

```bibtex
@software{hadoop,
  author = {{Dani Arribas-Bel}},
  title = {\texttt{gds_env}: A containerised platform for Geographic Data Science},
  url = {https://github.com/darribas/gds_env},
  version = {3.0},
  date = {2019-08-06},
}
```
