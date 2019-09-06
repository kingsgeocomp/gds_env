# How to pull and run this image
# > docker pull jreades/gsa:1.0
# > docker run --rm -ti -p 8888:8888 -v ${PWD}:/home/jovyan/work jreades/gsa:1.0
#
# How to build
# > docker build -t jreades/gsa:1.0 --compress .
# How to push an updated image
# > docker tag jreades/gsa:1.0 jreades/gsa:2019
# > docker tag jreades/gsa:1.0 jreades/gsa:latest
# > docker login docker.io
# > docker push jreades/gsa:1.0 jreades/gsa:latest
#
#--- Build from Jupyter-provided Minimal Install ---#
# https://github.com/jupyter/docker-stacks/blob/master/docs/using/selecting.md
# 2 Sept 2019
FROM jupyter/minimal-notebook:82d1d0bf0867

LABEL maintainer="jonathan.reades@kcl.ac.uk"

ENV base_nm gsa
ENV release_nm ${base_nm}2019
ENV kernel_nm 'GSA2019'

RUN echo "Building ${kernel_nm}"

# https://github.com/ContinuumIO/docker-images/blob/master/miniconda3/Dockerfile
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

#--- Python ---#

# Get conda updated and set up before installing
# any packages
RUN conda update -n base conda --yes \
    && conda config --add channels conda-forge \
    && conda config --set channel_priority strict

# Now install the packages then tidy up 
COPY ${base_nm}.yml /tmp/
RUN conda-env create -f /tmp/${base_nm}.yml \ 
    && conda clean --all --yes --force-pkgs-dirs \
    && find /opt/conda/ -follow -type f -name '*.a' -delete \
    && find /opt/conda/ -follow -type f -name '*.pyc' -delete \
    && find /opt/conda/ -follow -type f -name '*.js.map' -delete \
    && conda list

# Set paths for conda and PROJ
ENV PATH /opt/conda/envs/${release_nm}/bin:$PATH
ENV PROJ_LIB /opt/conda/envs/gsa2019/share/proj/
# And configure the bash shell params 
COPY init.sh /tmp/
RUN cat /tmp/init.sh > ~/.bashrc 
RUN echo "export PROJ_LIB=/opt/conda/envs/${release_nm}/share/proj/" >> ~/.bashrc

# Install jupyterlab extensions, but don't build
# (saves some time over install and building each)
RUN jupyter lab clean \
# These should work, but can be commented out for speed during dev
    && jupyter labextension install --no-build @jupyter-widgets/jupyterlab-manager \
    && jupyter labextension install --no-build jupyter-matplotlib \ 
    && jupyter labextension install --no-build jupyter-leaflet \
    && jupyter labextension install --no-build nbdime-jupyterlab \
    && jupyter labextension install --no-build @jupyterlab/toc \
    && jupyter labextension install --no-build ipysheet \ 
    && jupyter labextension install --no-build @jupyterlab/mathjax3-extension \ 
    && jupyter labextension install --no-build plotlywidget \ 
    && jupyter labextension install --no-build @jupyterlab/plotly-extension \ 
    && jupyter labextension install --no-build @jupyterlab/geojson-extension \ 
    && jupyter labextension install --no-build @krassowski/jupyterlab_go_to_definition \
    && jupyter labextension install --no-build @ryantam626/jupyterlab_code_formatter \ 
    && jupyter labextension install --no-build qgrid 
# Don't work currently
#    && jupyter labextension install --no-build pylantern \ 
#    && jupyter labextension install --no-build @oriolmirosa/jupyterlab_materialdarker \ 
#    && jupyter labextension install --no-build @jpmorganchase/perspective-jupyterlab \ 

# Build the jupyterlab extensions
RUN jupyter lab build \
    && jupyter labextension enable jupyterlab-manager \ 
    && jupyter labextension enable jupyter-matplotlib \
    && jupyter labextension enable jupyter-leaflet \ 
    && jupyter labextension enable nbdime-jupyterlab \
    && jupyter labextension enable toc \ 
    && jupyter labextension enable ipysheet \ 
    && jupyter labextension enable mathjax3-extension \ 
    && jupyter labextension enable plotlywidget \ 
    && jupyter labextension enable plotly-extension \
    && jupyter labextension enable geojson-extension \ 
    && jupyter labextension enable jupyterlab_go_to_definition \
    && jupyter labextension enable jupyterlab_code_formatter \
    && jupyter labextension enable qgrid 
#    && jupyter nbextension enable --py widgetsnbextension \ 

#--- JupyterLab config ---#
RUN echo "c.NotebookApp.default_url = '/lab'" \
    >> /home/$NB_USER/.jupyter/jupyter_notebook_config.py

# Clean up
RUN npm cache clean --force \
    && rm -rf $CONDA_DIR/share/jupyter/lab/staging\
    && rm -rf /home/$NB_USER/.cache/yarn

#--- Set up Kernelspec so name visible in chooser ---#
USER root
SHELL ["/bin/bash", "-c"]
RUN . /opt/conda/etc/profile.d/conda.sh \
    && conda activate ${release_nm} \
    && python -m ipykernel install --name ${release_nm} --display-name ${kernel_nm} \
    && ln -s /opt/conda/bin/jupyter /usr/local/bin

#--- htop ---#
RUN apt-get update \
    && apt-get install -y --no-install-recommends software-properties-common htop

#--- Texbuild ---#
RUN wget https://gist.github.com/darribas/e2a560e562139b139b67b7d1c998257c/raw/b2ec84e8eb671f3ebc2149a4d94d28a460ef9a7e/texBuild.py \
    && wget https://gist.github.com/darribas/e2a560e562139b139b67b7d1c998257c/raw/92b64d2d95768f1edc34a79dd13f957cc0b87bb3/install_texbuild.py \
    && cp texBuild.py /bin/texBuild.py \
    && python install_texbuild.py \
    && rm install_texbuild.py texBuild* \
    && fix-permissions $HOME \
    && fix-permissions $CONDA_DIR

# Switch back to user to avoid accidental container runs as root
USER $NB_UID

#COPY *.ipynb /home/$NB_USER/

RUN echo "Build complete."