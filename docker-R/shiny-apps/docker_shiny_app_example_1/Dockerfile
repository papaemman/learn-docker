# Dockerfile notes
# Choose a base image with FROM, run commands during the build with 
# RUN, copy files with COPY and define a startup command with CMD.

FROM continuumio/miniconda3:4.5.11

RUN apt-get update -y; apt-get upgrade -y; \
    apt-get install -y vim-tiny vim-athena ssh \
    build-essential gcc gfortran g++

# Always save your environments in a conda env file. 
# This makes it so much easier to fix your environment when you inadvertantly clobber it
# COPY (Relative to project) (/root)

COPY environment.yml environment.yml
RUN conda env create -f environment.yml
RUN echo "alias l='ls -lah'" >> ~/.bashrc

# This is the conda magic. If you are running through a shell just activating the environment in your profile is peachy
RUN echo "source activate r-shiny" >> ~/.bashrc

# This is the equivalent of running `source activate`
# Its handy to have in case you want to run additional commands in the Dockerfile
# env > before_activate.txt
# source activate r-shiny
# env > after_activate.txt
# diff before_activate.txt after_activate.txt

ENV CONDA_EXE /opt/conda/bin/conda
ENV CONDA_PREFIX /opt/conda/envs/r-shiny
ENV CONDA_PYTHON_EXE /opt/conda/bin/python
ENV CONDA_PROMPT_MODIFIER (r-shiny)
ENV CONDA_DEFAULT_ENV r-shiny
ENV PATH /opt/conda/envs/r-shiny/bin:/opt/conda/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# This is how we install custom R packages
# RUN R -e "install.packages('devtools', repos = 'http://cran.us.r-project.org')"

# Copy our app.R (or the entire project)
COPY app.R ./

CMD ["/bin/bash", "-c", "./app.R"]
