FROM --platform=linux/amd64 nvidia/cuda:12.1.1-devel-ubuntu22.04

# fix tzdata
ENV TZ=Etc/UTC
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install libpq-dev libprotobuf-dev protobuf-compiler cmake build-essential pkg-config curl wget python3-full python3-pip git-all htop curl vim -y

# install ollama
RUN curl -L https://ollama.com/download/ollama-linux-amd64.tgz -o ollama-linux-amd64.tgz
RUN tar -C /usr -xzf ollama-linux-amd64.tgz

# install python packages
RUN python3 -m pip install --upgrade pip
RUN pip install ollama
RUN pip install scipy pandas numpy

RUN date -u > /docker-build-time.txt
RUN echo "builder: GitHub Actions" >> /docker-build.txt
RUN echo "base: nvidia/cuda:12.1.1-devel-ubuntu22.04" >> /docker-build.txt
