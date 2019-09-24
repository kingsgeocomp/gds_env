# `gsa_env`: Geocomputation & Spatial Analysis Platform

This is a fork from [Dani's work](https://github.com/darribas/gds_env) (**please see below for citing**) to remove R as we don't need this for teaching but do have a few more Python packages that we _do_ use at King's. We've also added some JupyterLab extensions to make interacting with the Lab server a bit easier.

This repository contains two approaches to installation:

1. [Docker Desktop](https://www.docker.com/products/docker-desktop) and the [GSA Docker](https://cloud.docker.com/u/jreades/repository/docker/jreades/gsa) container
2. [Anaconda Python](https://www.anaconda.com/distribution/#download-section) and the supporting packages specified in the relevant YAML file ([full](https://github.com/kingsgeocomp/gsa_env/blob/master/gsa.yml) or [simplified](https://github.com/kingsgeocomp/gsa_env/blob/master/gsa_sm.yml)).

We are progressively migrating away from local installation via `conda` and towards the use of Docker for teaching since it ensures that all students have the same packages installed. However, if you simply want to play with the geo-data analysis stack or are on a low-powered machine unable to run Docker in full then direct installation may be appropriate.

A more detailed set of instructions can also be found in [Dani's Repo](https://github.com/darribas/gds19/tree/master/content/infrastructure). **Read this if you have trouble!**

## Requirements for Installing from Docker

You will need [Docker](https://www.docker.com) (Desktop) to be able to install the GSA environment. If you do not wish to create an account with Docker then you may want to follow advice [provided here](https://github.com/docker/docker.github.io/issues/6910#issuecomment-532393783) though we cannot condone it.

**Please note**: thers is an alternate 'smaller' Docker image that may be appropriate for those wishing to minise resource consumption (hard drive space, memory, etc.) that does _not_ contain the Bayesian elements, TeX (so no exporting to PDF), `htop`, and many fo the JupyterLab extensions. To install the smaller kernel you should simply add `_sm` to all places where `gsa` occurs below (_e.g._ `gsa:2019` becomes `gsa_sm:2019`). You do not normally install the `latest` version of any Docker image as it is likely to change without notice.

#### Installing (Best Option)

You can then install this container by opening up a Shell/Terminal and simply running:

> `docker pull jreades/gsa:2019`

#### Building (Alternative to Installing)

Docker is designed to make it easy to install the Geocomputation environment in it's entirety using just one command; however, if you want to build from source for some reason then the Docker image can be built by running:

> `docker build --rm -t jreades/gsa:2019 .`

You can check it has been built correctly by:

> `docker image ls`

And you should see one image with the name `gsa` and tag `2019` (in this example).

#### Running (Either Way)

The container can be run in the Shell or Terminal as:

> `docker run --name gsa --rm -ti -p 8888:8888 --mount type=bind,source="$(pwd)",target=/home/jovyan/ jreades/gsa:2019`

When you run this command you will then be able to point your browser to [localhost:8888](http://127.0.0.1:8888/lab?). You are likely to be prompted to enter a **Token**. The token should have been shown in the Shell/Terminal output shortly after you ran the above command: you can copy+paste this into the web page and should then see something like the below in your browser window:

<img src="JupyterLab.png" width="500">

A couple of notes on the command above:

* This opens the `8888` port of the container, so to access the Lab instance,
  you will have to point your browser to `localhost:8888` and insert the token
  printed on the terminal
* The command also mounts the current folder (`pwd`) to the container, but you can replace that with the path to any folder on your local machine (in fact, that will only work on host machines with the `pwd` command installed)
* The `name` ensures that you don't accidentally run three versions of the same Docker image!
* You can add `-d` after `-ti` to run the command in the background so it doesn't take over your Terminal (though that can make it hard to find the Token!).

We've put together a video (without audio!) of how to do this on a Mac and the process should be similar on a Windows machine:

[![You Tube Video](http://img.youtube.com/vi/5rh_bwxzjNs/0.jpg)](https://www.youtube.com/watch?v=5rh_bwxzjNs)

#### Deleting

Should you wish to remove the image and container from your system then the following approaches are available:

##### Deleting by Filter

This should be used with some care since it will try to delete all matching images and this may not be what you want:

```bash
docker ps -aqf "name=gsa" --format="{{.Image}} {{.Names}} {{.ID}}" | grep "2019" | cut -d' ' -f3 | xargs docker rm -f
docker images --format="{{.Repository}} {{.Tag}} {{.ID}}" | grep "gsa" | cut -d' ' -f3 | xargs docker rmi
```

##### Deleting by Image

```bash
docker ps -aq # Get list of running processes and work out container IDs to remove
docker rm -f <list of container IDs>
docker images # Get list of available images and work out image IDs to remove
docker rmi -f <list of image IDs>
```

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
