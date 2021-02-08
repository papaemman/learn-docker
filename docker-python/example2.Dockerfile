# Use latest Python runtime as a parent image
FROM python:3.5.3-slim

# Meta-data
LABEL maintainer="Panagiotis Papaemmanouil <papaemman.pan@gmail.com>"\
      description="Data Science Workflow" 

# Set the working directory to /app
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install the required libraries
RUN pip --no-cache-dir install numpy pandas seaborn sklearn jupyter


# Make port 8888 available to the world outside this container
EXPOSE 8888

# Run jupyter when container launches
CMD ["jupyter","notebook", "--ip=`*`", "--port=8888", "--no-browser", "--allow-root"]