# Use Ubuntu Xenial as a base image
FROM --platform=amd64 ubuntu:16.04

WORKDIR "/root"

# Download and install ESA SNAP version 7.0 / raise JVM memory limit up to 4GB
RUN apt-get -q update \
    && apt -y install openjdk-8-jre wget \
    && wget -q http://step.esa.int/downloads/7.0/installers/esa-snap_sentinel_unix_7_0.sh \
    && apt-get -y purge --auto-remove wget \
    && rm -rf /var/lib/apt/lists/* \
    && chmod +x esa-snap_sentinel_unix_7_0.sh \
    && ./esa-snap_sentinel_unix_7_0.sh -q \
    && rm esa-snap_sentinel_unix_7_0.sh \
    && rm -rf /usr/local/snap/jre \
    && ln -s /usr/lib/jvm/java-8-openjdk-amd64/jre /usr/local/snap/jre \
    && sed -i -e 's/-Xmx1G/-Xmx4G/g' /usr/local/snap/bin/gpt.vmoptions

ENV LD_LIBRARY_PATH .
ENV PATH /usr/local/snap/bin:$PATH

# Set entrypoint to Graph Processing Tool executable
ENTRYPOINT ["/usr/local/snap/bin/gpt"]
CMD ["-h"]
