FROM rocker/r-ver:3.6.1

# Arguments passed
ARG GIT_USERNAME
ARG GIT_PASSWORD
ARG GIT_URL=github.com/medoidai/stationarity.git
ARG GIT_BRANCH
ARG FOLDER

# Install system packages
RUN apt-get update && apt-get install -y \
    sudo \
    gdebi-core \
    pandoc \
    pandoc-citeproc \
    libcurl4-gnutls-dev \
    libcairo2-dev \
    libxt-dev \
    xtail \
    wget \
    git \
    libxml2-dev \
    libgit2-dev \
    libssl-dev \
    libssh2-1-dev \
    cargo\
    libmagick++-dev \
    nano \
    vim

# Download and install shiny server
RUN wget --no-verbose https://download3.rstudio.org/ubuntu-14.04/x86_64/VERSION -O "version.txt" && \
    VERSION=$(cat version.txt)  && \
    wget --no-verbose "https://download3.rstudio.org/ubuntu-14.04/x86_64/shiny-server-$VERSION-amd64.deb" -O ss-latest.deb && \
    gdebi -n ss-latest.deb && \
    rm -f version.txt ss-latest.deb && \
    . /etc/environment && \
    chown shiny:shiny /var/lib/shiny-server

# Clone repository files
RUN cd /srv/shiny-server/ \
    && mkdir ${FOLDER} \
    && mkdir kitematic \
    && git clone --recursive https://${GIT_USERNAME}:${GIT_PASSWORD}@${GIT_URL} ${FOLDER} \
    && cd /srv/shiny-server/${FOLDER}/ \
    && git checkout ${GIT_BRANCH}

# Install / Run packrat
RUN R -e "install.packages(c('packrat'), dependencies = TRUE, repos='http://cran.rstudio.com/')"

RUN  R -e "setwd('/srv/shiny-server/${FOLDER}');packrat::on(); packrat::restore()" 

# Rscript instead of R

EXPOSE 3838

COPY shiny-server.sh /usr/bin/shiny-server.sh

RUN chmod +x /usr/bin/shiny-server.sh

CMD ["/usr/bin/shiny-server.sh"]
