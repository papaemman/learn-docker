##Stationarity Mathisys dev/prod Dockerfile

FROM medoid-ai-docker-r
##ENV PATH=$PATH:/opt/TinyTeX/bin/x86_64-linux/

ARG GIT_USERNAME
ARG GIT_PASSWORD
ARG GIT_EMAIL
##We set a default git https just to show the format - part of address you write - without https etc
ARG GIT_HTTPS=bitbucket.org/medoidai/stationarity.git
ARG GIT_BRANCH=test-branch
ARG FOLDER
ARG SQL_JDBC_PATH=${FOLDER}/..

RUN apt-get update \
&& apt-get install -y --no-install-recommends unixodbc \
&& apt-get install -y --no-install-recommends unixodbc-dev \
&& apt-get install -y --no-install-recommends freetds-dev \
&& apt-get install -y --no-install-recommends tdsodbc \
&& apt-get install -y --no-install-recommends libgsl0-dev \
&& apt-get install -y --no-install-recommends gnupg \
&& apt-get install -y --no-install-recommends curl \
&& apt-get install -y --no-install-recommends apt-transport-https \
## RJDBC for Debian 9
&& curl https://download.microsoft.com/download/0/2/A/02AAE597-3865-456C-AE7F-613F99F850A8/sqljdbc_6.0.8112.200_enu.tar.gz --create-dirs -o ${SQL_JDBC_PATH}/sqljdbc_6.0.8112.200_enu.tar.gz \
&& chmod 777 -R ${SQL_JDBC_PATH} \
&& tar -xvf ${SQL_JDBC_PATH}/sqljdbc_6.0.8112.200_enu.tar.gz -C ${SQL_JDBC_PATH} \
&& curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
## ODBC for Debian 9
&& curl https://packages.microsoft.com/config/debian/9/prod.list > /etc/apt/sources.list.d/mssql-release.list \
&& apt-get update \
&& ACCEPT_EULA=Y apt-get install msodbcsql17
## the following are optional: for bcp and sqlcmd
##sudo ACCEPT_EULA=Y apt-get install mssql-tools
##echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bash_profile
##echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc
#source ~/.bashrc

USER rstudio

RUN cd /home/rstudio/ \
&& mkdir ${FOLDER} \
## If you want to download a specific branch only
## && git clone --recursive --branch ${GIT_BRANCH} https://${GIT_USERNAME}:${GIT_PASSWORD}@${GIT_HTTPS} ${FOLDER} \
&& git clone --recursive https://${GIT_USERNAME}:${GIT_PASSWORD}@${GIT_HTTPS} ${FOLDER} \
&& cd /home/rstudio/${FOLDER}/ \
&& git checkout ${GIT_BRANCH} \
##Packages youd 'd prefer to ignore
&& Rscript -e 'packrat::set_opts(ignored.packages=c("BioInstaller"))' \
&& Rscript -e "packrat::restore(prompt = FALSE)" \
&& git config --global user.email "${GIT_EMAIL}" \
&& git config --global user.name "${GIT_USERNAME}" \
&& git remote set-url origin https://${GIT_USERNAME}@${GIT_HTTPS}

USER root
RUN cd //
