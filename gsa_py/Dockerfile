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
# RUN jupyter labextension install @jupyter-widgets/jupyterlab-manager \
# Enable nbdime
# && jupyter labextension update nbdime-jupyterlab \

# Set up kernel
CMD python -m ipykernel install --display-name "GSA 2019" --user

