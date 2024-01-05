# Custom data science notebook for LANDER
ARG OWNER=vvcb
ARG BASE_CONTAINER=crlander.azurecr.io/vvcb/datascience-notebook:latest
FROM $BASE_CONTAINER

LABEL maintainer="vvcb"
USER root
RUN apt update
RUN apt install --yes octave
RUN apt install --yes octave-doc
RUN apt install --yes octave-control
RUN apt install --yes octave-image
RUN apt install --yes octave-io
RUN apt install --yes octave-optim
RUN apt install --yes octave-signal
RUN apt install --yes octave-statistics

RUN mamba install --quiet --yes \
    'octave_kernel' \
    'texinfo'
RUN mamba clean --all -f -y && \
    fix-permissions "${CONDA_DIR}" && \
    fix-permissions "/home/${NB_USER}"
COPY jupyter_notebook_config.json /etc/jupyter/jupyter_notebook_config.json
USER ${NB_USER}