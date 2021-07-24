# Use Ubuntu 16.04 LTS
FROM ubuntu:xenial-20200114

# Installing and setting up miniconda
RUN curl -sSLO https://repo.continuum.io/miniconda/Miniconda3-4.5.11-Linux-x86_64.sh && \
    bash Miniconda3-4.5.11-Linux-x86_64.sh -b -p /usr/local/miniconda && \
    rm Miniconda3-4.5.11-Linux-x86_64.sh

# Installing precomputed python packages
RUN conda install -y python=3.7.1 && sync && \
    chmod -R a+rX /usr/local/miniconda; sync && \
    chmod +x /usr/local/miniconda/bin/*; sync && \
    conda build purge-all; sync && \
    conda clean -tipsy && sync

# Install wkhtmltopdf with Qt patch
RUN wget https://github.com/wkhtmltopdf/wkhtmltopdf/releases/download/0.12.4/wkhtmltox-0.12.4_linux-generic-amd64.tar.xz && \
    tar xvf wkhtmltox-0.12.4_linux-generic-amd64.tar.xz && \
    mv wkhtmltox/bin/wkhtmlto* /usr/bin/ && \
    rm -rf wkhtmltox-0.12.4_linux-generic-amd64.tar.xz

#Install pdfkit and xvfbwrapper, generate machine ID
RUN pip install --no-cache-dir pdfkit && \
    pip install --no-cache-dir xvfbwrapper && \
    dbus-uuidgen > /etc/machine-id

# Best practices
RUN ldconfig
WORKDIR /tmp/

COPY run_test.sh /opt/run_test.sh

# Entrypoint
ENTRYPOINT ["/opt/run_test.sh"]

