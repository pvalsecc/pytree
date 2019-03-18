FROM ubuntu:18.04

COPY requirements.txt fake_python3 /app/

RUN apt update && \
    DEV_PACKAGES="build-essential python3.7-dev equivs" && \
    DEBIAN_FRONTEND=noninteractive apt install --yes --no-install-recommends python3.7 curl $DEV_PACKAGES && \
    equivs-build /app/fake_python3 && \
    dpkg -i python3_3.7.1-1~18.04_amd64.deb && \
    rm python3_3.7.1-1~18.04_amd64.deb && \
    ln -s pip3 /usr/bin/pip && \
    ln -s python3.7 /usr/bin/python && \
    ln -sf python3.7 /usr/bin/python3 && \
    DEBIAN_FRONTEND=noninteractive apt install --yes --no-install-recommends \
        python3-pip \
        python3-setuptools \
        python3-wheel \
        python3-pkgconfig && \
    apt-get clean && \
    rm -r /var/lib/apt/lists/* && \
    pip install --no-cache-dir -r /app/requirements.txt && \
    apt remove --purge --autoremove --yes $DEV_PACKAGES binutils

COPY . /app

WORKDIR /app
EXPOSE 5001

CMD python runserver.py
