FROM ubuntu
EXPOSE 8888
RUN apt-get update -y;
RUN apt-get install
RUN apt-get install -y python3 python3-pip
RUN pip3 install  --upgrade pip		
RUN pip3 install jupyterlab ;


