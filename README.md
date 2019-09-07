# `gsa_env`: Geocomputation & Spatial Analysis Platform

This is a fork from [Dani's work](https://github.com/darribas/gds_env) (**please see below for citing**) to remove R as we don't need this for teaching but do have a few more Python packages that we _do_ use at King's. We've also added some JupyterLab extensions to make interacting with the Lab server a bit easier.

This repository contains two approaches to installation:

1. [Docker Desktop](https://www.docker.com/products/docker-desktop) and the [GSA Docker](https://cloud.docker.com/u/jreades/repository/docker/jreades/gsa) container
2. [Anaconda Python](https://www.anaconda.com/distribution/#download-section) and the supporting packages specified in the relevant YAML file ([full](https://github.com/kingsgeocomp/gsa_env/blob/master/gsa.yml) or [simplified](https://github.com/kingsgeocomp/gsa_env/blob/master/gsa_sm.yml)).

We are progressively migrating away from local installation via `conda` and towards the use of Docker for teaching since it ensures that all students have the same packages installed. However, if you simply want to play with the geo-data analysis stack or are on a low-powered machine unable to run Docker in full then direct installation may be appropriate.

A more detailed set of instructions can also be found in [Dani's Repo](https://github.com/darribas/gds19/tree/master/content/infrastructure). **Read this if you have trouble!**

## Requirements for Installing from Docker

You will need [Docker](https://www.docker.com) (Desktop) to be able to install the GSA environment.

#### Installing

You can then install this container by opening up a Shell/Terminal and simply running:

> `docker pull jreades/gsa:1.0`

#### Building

If, instead, you want to build from source, the Docker image can be built by running:

> `docker build -t jreades/gsa:1.0 .`

You can check it has been built correctly by:

> `docker image ls`

And you should see one image with the name `gsa` and tag `1.0` (in this example).

#### Running

The container can be run in the Shell or Terminal as:

```bash
> docker run --rm -ti -p 8888:8888 -v ${pwd}:/home/jovyan/host jreades/gsa:1.0
```

The first time you run this command and attempt to log in by pointing your browser to [localhost:8888](http://127.0.0.1:8888/lab?) you are likely to be prompted to enter a **Token**. The token will have been shown in the Shell/Terminal output shortly after you ran the above command: you can copy+paste this into the web page and should then see something like the below in your browser window:

<img src="JupyterLab.png" width="500">

A couple of notes on the command above:

* This opens the `8888` port of the container, so to access the Lab instance,
  you will have to point your browser to `localhost:8888` and insert the token
  printed on the terminal
* The command also mounts the current folder (`pwd`) to the container, but you can replace that with the path to any folder on your local machine (in fact, that will only work on host machines with the `pwd` command installed)

## Requirements for Direct Installation

You will need [Anaconda Python](https://www.anaconda.com/distribution/#download-section) to be able to install the GSA environment.

#### Installing

After downloading and installing Anaconda Python you will need to work out how to use the AnacondaPrompt (Windows) or Terminal (Mac) in order to navigate to the folder holding the YAML file ([full](https://github.com/kingsgeocomp/gsa_env/blob/master/gsa.yml) or [small](https://github.com/kingsgeocomp/gsa_env/blob/master/gsa_sm.yml))

> `conda-env create -f gsa.yml` (for the full version, change `gsa` to `gsa_sm` for smaller kernel)

#### Configuring

To make this new 'kernel' available in JupyterLab you then need to install a `kernelspec` as follows:

```bash
conda activate gsa2019 # this should match the line beginning `name: ...` in the YAML file
python -m ipykernel install --name gsa2019 --display-name "Geocomp 2019" # Note match of 'names', display name can be anything
```

#### Running

> `jupyter lab` or from the Anaconda Navigator if you prefer.

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
