FROM pytorch/pytorch:2.6.0-cuda12.6-cudnn9-runtime

WORKDIR /app

# 환경 변수 설정
ENV DEBIAN_FRONTEND=noninteractive \
    TZ=Asia/Seoul \
    LANG=ko_KR.UTF-8 \
    LANGUAGE=ko_KR:ko \
    LC_ALL=ko_KR.UTF-8

# 의존성 설치, 시간대 설정, 로케일 생성 및 정리
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    wget \
    zlib1g-dev \
    libncurses5-dev \
    libgdbm-dev \
    libnss3-dev \
    libssl-dev \
    libsqlite3-dev \
    libreadline-dev \
    libffi-dev \
    libbz2-dev \
    liblzma-dev \
    tk-dev \
    uuid-dev \
    tzdata \
    git \
    libaio1 \
    unzip \
    sudo \
    libxml2 \
    locales && \
    ln -fs /usr/share/zoneinfo/$TZ /etc/localtime && \
    dpkg-reconfigure --frontend noninteractive tzdata && \
    locale-gen ko_KR.UTF-8 && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

Run pip install --upgrade pip

COPY requirements.txt /app

RUN pip install --no-cache-dir -r /app/requirements.txt 

RUN wget https://github.com/git-lfs/git-lfs/releases/download/v3.1.4/git-lfs-linux-amd64-v3.1.4.tar.gz && \
    tar -xzf git-lfs-linux-amd64-v3.1.4.tar.gz && \
    ./install.sh && \
    rm -rf git-lfs-linux-amd64-v3.1.4.tar.gz install.sh README.md CHANGELOG.md LICENSE.md

WORKDIR /vol