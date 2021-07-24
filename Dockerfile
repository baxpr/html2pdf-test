# Use Ubuntu 16.04 LTS
FROM ubuntu:xenial-20200114

RUN apt-get update && \
    apt-get install -y --no-install-recommends wget ca-certificates \
    xz-utils \
    libxrender1 libfontconfig1-dev libxext-dev && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install wkhtmltopdf with Qt patch
RUN wget -q http://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.4/wkhtmltox-0.12.4_linux-generic-amd64.tar.xz && \
    tar -xf wkhtmltox-0.12.4_linux-generic-amd64.tar.xz && \
    mv wkhtmltox/bin/wkhtmlto* /usr/bin/ && \
    rm -rf wkhtmltox-0.12.4_linux-generic-amd64.tar.xz

COPY run_test.sh /opt/run_test.sh

# Entrypoint
ENTRYPOINT ["wkhtmltopdf"]

