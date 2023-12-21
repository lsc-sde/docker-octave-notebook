# Custom data science notebook for LANDER
ARG OWNER=vvcb
ARG BASE_CONTAINER=crlander.azurecr.io/vvcb/datascience-notebook:latest
FROM $BASE_CONTAINER

LABEL maintainer="vvcb"
USER root
RUN apt update && apt install --yes \
    octave \
    octave-doc \
    octave-info \
    octave-htmldoc \
    octave-control \
    octave-image \
    octave-io \
    octave-optim \
    octave-signal \
    octave-statistics
RUN mamba install --quiet --yes \
    'octave_kernel' \
    'texinfo'
RUN mamba clean --all -f -y && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"
COPY files/config/jupyter_notebook_config.json /etc/jupyter/jupyter_notebook_config.json
USER ${NB_USER}