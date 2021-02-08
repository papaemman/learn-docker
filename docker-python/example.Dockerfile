# Base Image
FROM python:3


# Main Instructions
COPY yourscript.py /
RUN pip install flask

# Entry command
CMD ["python", "./yourscript.py"]


# --------------------

# Always Use a concrete tag (avoid LATEST)
FROM jupyter/base-notebook:6.0.3


# Add metadata
LABEL mainainer="Panagiotis Papaemmanouil"
LABEL securitytxt="security.txt"

# Use pinedd versions always
RUN conda install --quiet --yes \
    'pandas==1.0.3' \
    'dask=2.14.*'\
    && \
    # do not forget to clean - reduce image
    conda clean --all -f -y

# Separate instructions per scope
RUN mkdir data-sci-demo


COPY ./your-project data-sci-demo/


# --------------------


FROM python:3:8:2-slim-buster
RUN useradd --create-home jovyan
WORKDIR /home/jovyab
USER jovyan




