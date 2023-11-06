# Use an official Python runtime as a parent image
FROM python:3.9.18-bullseye

LABEL maintainer "Panagiotis Papaemmanouil, DataMinds PC, panos@dataminds.gr"

# Install nano, cron
RUN apt-get update
RUN apt-get install nano
RUN apt-get -y install cron

# Install poetry (SOS: Use the same poetry version as in the system created the poetry.lock)
RUN pip install poetry==1.7.0
ENV POETRY_NO_INTERACTION=1 \
    POETRY_VIRTUALENVS_IN_PROJECT=1 \
    POETRY_VIRTUALENVS_CREATE=1 \
    POETRY_CACHE_DIR=/tmp/poetry_cache

# Set the working directory to /water-ai
WORKDIR /water-ai

# Copy the poetry files
COPY pyproject.toml poetry.lock ./

# Install dependencies
RUN poetry install --no-root && rm -rf $POETRY_CACHE_DIR

# Copy the current directory contents into the container at /water-ai
COPY . /water-ai

# Make port 8050 available to the world outside this container
EXPOSE 8050

# Define environment variable
ENV NAME World

# Copy crontab file to the cron.d directory
COPY crontab /etc/cron.d/crontab

# Give execution rights on the cron job
RUN chmod 0644 /etc/cron.d/crontab

# Apply cron job
RUN crontab /etc/cron.d/crontab

# Create the log file to be able to run tail
RUN touch /var/log/cron.log

# Run app/run_app.py when the container launches using poetry
# CMD cron && cd app && poetry run python run_app.py
CMD cron && cd app && poetry run gunicorn --bind 0.0.0.0:8050 run_app:server
