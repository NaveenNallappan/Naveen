FROM --platform=linux/arm64/V8 amazonlinux:2023
RUN dnf upgrade -y && \
    dnf install -y wget \
    gcc make openssl-devel bzip2-devel libffi-devel zlib-devel tar gzip
RUN wget https://www.python.org/ftp/python/3.11.5/Python-3.11.5.tgz && \
    tar xzf Python-3.11.5.tgz && \
    cd Python-3.11.5 && \
    ./configure --enable-optimizations && \
    make -j 8 && \
    make altinstall && \
    cd .. && \
    rm -rf Python-3.11.5 Python-3.11.5.tgz
RUN ln -s /usr/local/bin/python3.11 /usr/local/bin/python && \
    ln -s /usr/local/bin/pip3.11 /usr/local/bin/pip
RUN pip3.11 install pipenv
RUN pip3.11 install runway
RUN curl -fsSL https://rpm.nodesource.com/setup_18.x | bash - && \
    dnf install -y nodejs
RUN npm install -g serverless