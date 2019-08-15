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
    && jupyter labextension install jupyter-matplotlib \ 
#    && jupyter labextension install pylantern \ 
#    && jupyter labextension install @oriolmirosa/jupyterlab_materialdarker \ 
#    && jupyter labextension install @jupyterlab/geojson-extension \ 
#    && jupyter labextension install @jupyterlab/mathjax3-extension \ 
#    && jupyter labextension install @jupyterlab/plotly-extension \
#    && jupyter labextension install @krassowski/jupyterlab_go_to_definition \
#    && jupyter labextension install @ryantam626/jupyterlab_code_formatter \ 
    && jupyter nbextension enable --py widgetsnbextension

# Set up kernel
RUN python -m ipykernel install --display-name "GSA 2019" --user

COPY *.ipynb /home/$NB_USER/

