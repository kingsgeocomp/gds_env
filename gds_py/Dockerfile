# July'19
FROM jupyter/minimal-notebook:307ad2bb5fce

MAINTAINER Jon Reades <jonathan.reades@kcl.ac.uk>

# https://github.com/ContinuumIO/docker-images/blob/master/miniconda3/Dockerfile
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

#--- Python ---#

RUN conda update conda --yes \
    && conda config --add channels conda-forge \
    && conda config --set channel_priority strict \
    && conda install --yes --quiet \
     'python=3.7' \
     'bambi' \
     'black' \
     'bokeh' \
     'colorama' \
     'contextily==1.0rc2' \
     'cython' \
     'dask' \
     'dask-ml' \
     'datashader' \
     'dill' \
     'feather-format' \
     'folium' \ 
     'geojson' \
     'geopandas' \
     'geopy' \
     'georasters' \
     'gitdb2' \
     'gitpython' \
     'hdbscan' \
     'ipyleaflet' \
     'ipyparallel' \
     'ipywidgets' \
     'jupyterlab' \ 
     'lxml' \ 
     'mapclassify' \
     'mkl-service' \
     'mplleaflet' \
     'mysql-connector-python' \ 
     'nb_conda' \ 
     'nbdime' \
     'networkx' \
     'osmnx' \
     'palettable' \
     'pandana' \
     'pillow' \
     'pointpats' \ 
     'polyline' \
     'pyarrow' \
     'pykrige' \
     'pymc3' \
     'pysal=2.0.0' \
     'pystan' \
     'qgrid' \
     'rasterio' \
     'rasterstats' \
     'requests' \ 
     'scikit-image' \
     'scikit-learn' \
     'seaborn' \
     'simplejson' \
     'smmap2' \
     'sqlite' \ 
     'sqlalchemy' \ 
     'statsmodels' \
     'tzlocal' \
     'urbanaccess' \
     'xlrd' \
     'xlsxwriter' \
     && conda clean --all --yes --force-pkgs-dirs \
     && find /opt/conda/ -follow -type f -name '*.a' -delete \
     && find /opt/conda/ -follow -type f -name '*.pyc' -delete \
     && find /opt/conda/ -follow -type f -name '*.js.map' -delete \
     && conda list

# Enable widgets in Jupyter
RUN jupyter labextension install @jupyter-widgets/jupyterlab-manager \
# Enable ipyleaflet
 && jupyter labextension install jupyter-leaflet \
# Enable qgrid
 && jupyter labextension install qgrid \
# Enable nbdime
 && nbdime extensions --enable --user $NB_USER \
 && jupyter labextension update nbdime-jupyterlab \
#--- Jupyter config ---#
 && echo "c.NotebookApp.default_url = '/lab'" \
 >> /home/$NB_USER/.jupyter/jupyter_notebook_config.py

# Install via pip
pip3 install --yes \
     'pykrige' \ 
     'googlemaps' \ 
     'smopy' \ 
     'git+http://github.com/kingsgeocomp/SOMPY#egg=sompy'

# Clean up
RUN npm cache clean --force \
 && rm -rf $CONDA_DIR/share/jupyter/lab/staging\
 && rm -rf /home/$NB_USER/.cache/yarn

# Set up kernel
python -m ipykernel isntall --display-name "GSA 2019"

#--- htop ---#

USER root

RUN apt-get update \
 && apt-get install -y --no-install-recommends software-properties-common htop

# Switch back to user to avoid accidental container runs as root
USER $NB_UID
