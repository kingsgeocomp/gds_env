FROM darribas/gds_py:3.0

MAINTAINER Jon Reades <jonathan.reades@kcl.ac.uk>

#--- Python ---#

COPY conda_requirements.txt /tmp/

# Additional conda libs not installed 
# by Dani's version 
RUN conda install --yes --quiet --file /tmp/conda_requirements.txt \ 
    && conda clean --all --yes --force-pkgs-dirs \
    && find /opt/conda/ -follow -type f -name '*.a' -delete \
    && find /opt/conda/ -follow -type f -name '*.pyc' -delete \
    && find /opt/conda/ -follow -type f -name '*.js.map' -delete \
    && conda list
#COPY . /tmp/

# Install via pip
# --no-deps -- after making sure you have the conda libs installed
COPY pip_requirements.txt /tmp/
RUN pip install --no-cache-dir --no-deps -r /tmp/pip_requirements.txt 
#COPY . /tmp/

# Enable widgets in Jupyter
RUN jupyter labextension install @jupyterlab/toc \
    && jupyter labextension install --no-build jupyter-matplotlib \ 
# Doesn't work currently
#    && jupyter labextension install --no-build pylantern \ 
# Doesn't work currently
#    && jupyter labextension install --no-build @oriolmirosa/jupyterlab_materialdarker \ 
    && jupyter labextension install --no-build ipysheet \ 
    && jupyter labextension install --no-build plotlywidget \ 
    && jupyter labextension install --no-build @jpmorganchase/perspective-jupyterlab \ 
    && jupyter labextension install --no-build @jupyterlab/mathjax3-extension \ 
    && jupyter labextension install --no-build @jupyterlab/geojson-extension \ 
    && jupyter labextension install --no-build @jupyterlab/plotly-extension \ 
    && jupyter labextension install --no-build @krassowski/jupyterlab_go_to_definition \
    && jupyter labextension install --no-build @ryantam626/jupyterlab_code_formatter \ 
    && jupyter lab build \ 
    && jupyter nbextension enable --py widgetsnbextension

# Set up kernel
RUN python -m ipykernel install --display-name "GSA 2019" --user

COPY *.ipynb /home/$NB_USER/

