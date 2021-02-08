# Always use a concrete tag (avoid LATEST)
FROM python:3.8.2-slim-buster as compile-image


# Add metadata
LABEL mainainer="Panagiotis Papaemmanouil"
LABEL securitytxt="security.txt"

RUN apt-get update

RUN apt-get install -y --no-install-recommends gcc build-essential gcc gfortran

RUN python -m venv /opt/venv

# Ensure we use the virtualenv
ENV PATH="/opt/venv/bin:$PATH"

COPY requirements.txt /tmp/

RUN CFLAGS = "-g0 -Wl,--strip-all -I/usr/include:/usr/local/include -L/usr/lib:/usr/local/lib" \
    pip install \
    --no-cache-dir \
    --compile \
    --global-option=build_ext \
    --global-option="-j 4"\
    -r /tmp/requirements.txt

# -----------------------------------------
# This is the second image that copies the compiled library

FROM python:3.8.2-slim-buster as runtime-image

COPY --from=compile-image /opt/venv /opt/venv

# Ensure we use the virtualenv
ENV PATH="/opt/venv/bin:$PATH"
