# Use Debian Buster as a base image
FROM debian:10.3

WORKDIR "/root"

# Download and install ESA SNAP version 7.0 / raise JVM memory limit up to 4GB
RUN apt-get -q update \
    && apt-get -y install wget \
    && wget -q http://step.esa.int/downloads/7.0/installers/esa-snap_sentinel_unix_7_0.sh \
    && apt-get -y purge --auto-remove wget \
    && rm -rf /var/lib/apt/lists/* \
    && chmod +x esa-snap_sentinel_unix_7_0.sh \
    && ./esa-snap_sentinel_unix_7_0.sh -q \
    && rm esa-snap_sentinel_unix_7_0.sh \
    && sed -i -e 's/-Xmx1G/-Xmx4G/g' /usr/local/snap/bin/gpt.vmoptions

ENV LD_LIBRARY_PATH .
ENV PATH /usr/local/snap/bin:$PATH

# Set entrypoint to Graph Processing Tool executable
ENTRYPOINT ["/usr/local/snap/bin/gpt"]
CMD ["-h"]
