FROM darribas/gds_py:3.0

MAINTAINER Jon Reades <jonathan.reades@kcl.ac.uk>

#--- Python ---#

# Additional conda libs not installed 
# by Dani's version 
RUN conda update conda --yes \
    && conda config --set channel_priority strict \
    && conda install --yes --quiet \ 
    'beautifulsoup4' \ 
    'folium' \
    'geojson' \
    'georasters' \
    'joblib' \
    'jupyterlab' \
    'libspatialite' \
    'lxml' \
    'mysql-connector-python' \
    'nodejs' \
    'pointpats' \ 
    'pykrige' \
    'pyshp' \
    'requests' \
    'simplejson' \
    'sqlalchemy' \
    && conda clean --all --yes --force-pkgs-dirs \
    && find /opt/conda/ -follow -type f -name '*.a' -delete \
    && find /opt/conda/ -follow -type f -name '*.pyc' -delete \
    && find /opt/conda/ -follow -type f -name '*.js.map' -delete \
    && conda list

# Install via pip
# --no-deps -- after making sure you have the conda libs installed
RUN pip3 install --no-deps --yes \
     'googlemaps' \ 
     'smopy' \ 
     'git+http://github.com/kingsgeocomp/SOMPY#egg=sompy'

# Enable widgets in Jupyter
# RUN jupyter labextension install @jupyter-widgets/jupyterlab-manager \
# Enable nbdime
# && jupyter labextension update nbdime-jupyterlab \

# Set up kernel
RUN python -m ipykernel install --display-name "GSA 2019"
