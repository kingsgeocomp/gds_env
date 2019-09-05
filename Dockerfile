# https://github.com/jupyter/docker-stacks/blob/master/docs/using/selecting.md
# 2 Sept 2019
#FROM jupyter/minimal-notebook:82d1d0bf0867 as jup

# July'19
FROM jupyter/minimal-notebook:307ad2bb5fce

LABEL maintainer="jonathan.reades@kcl.ac.uk"

ENV base_nm gsa
ENV release_nm gsa2019
ENV kernel_nm 'GSA2019'

RUN echo ${kernel_nm}

# https://github.com/ContinuumIO/docker-images/blob/master/miniconda3/Dockerfile
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

#--- Python ---#

# Get conda updated and set up before installing
# any packages
RUN conda update -n base conda --yes \
    && conda config --add channels conda-forge \
    && conda config --set channel_priority strict

# Now install the packages -- we 
COPY ${base_nm}.yml /tmp/
RUN conda-env create -f /tmp/${base_nm}.yml \ 
    && conda clean --all --yes --force-pkgs-dirs \
    && find /opt/conda/ -follow -type f -name '*.a' -delete \
    && find /opt/conda/ -follow -type f -name '*.pyc' -delete \
    && find /opt/conda/ -follow -type f -name '*.js.map' -delete \
    && conda list

SHELL ["/bin/bash", "-c"]
RUN conda init 
RUN echo "conda activate ${release_nm}" > ~/.bashrc
SHELL ["/bin/bash", "-c"]

# Install via pip
# --no-deps -- after making sure you have the conda libs installed
#COPY pip_requirements.txt /tmp/
#RUN pip install --no-cache-dir --no-deps -r /tmp/pip_requirements.txt 
#COPY . /tmp/

# Enable widgets in Jupyter
RUN jupyter lab clean \
    && jupyter labextension install --no-build @jupyter-widgets/jupyterlab-manager \
    && jupyter labextension install --no-build jupyter-leaflet \
    && jupyter labextension install --no-build jupyter-matplotlib \ 
# Doesn't work currently
#    && jupyter labextension install --no-build pylantern \ 
# Doesn't work currently
#    && jupyter labextension install --no-build @oriolmirosa/jupyterlab_materialdarker \ 
#    && jupyter labextension install --no-build @jpmorganchase/perspective-jupyterlab \ 
# These should work, but commented out for speed
    && jupyter labextension install --no-build @jupyterlab/toc \
    && jupyter labextension install --no-build ipysheet \ 
    && jupyter labextension install --no-build plotlywidget \ 
    && jupyter labextension install --no-build @jupyterlab/mathjax3-extension \ 
    && jupyter labextension install --no-build @jupyterlab/plotly-extension \ 
    && jupyter labextension install --no-build @jupyterlab/geojson-extension \ 
    && jupyter labextension install --no-build @krassowski/jupyterlab_go_to_definition \
    && jupyter labextension install --no-build @ryantam626/jupyterlab_code_formatter 
 
RUN jupyter lab build  
#    && jupyter nbextension enable --py widgetsnbextension \ 
#    && jupyter labextension enable jupyterlab_code_formatter \ 
RUN jupyter labextension enable jupyterlab-manager 
#    && jupyter labextension enable jupyter-leaflet \ 
#    && jupyter labextension enable jupyter-matplotlib 

USER root
RUN python -m ipykernel install --name ${release_nm} --display-name ${kernel_nm}
USER $NB_UID

COPY *.ipynb /home/$NB_USER/

# To push
# docker tag <IMAGE ID> jreades/gsa:1.0
# docker push jreades/gsa:1.0