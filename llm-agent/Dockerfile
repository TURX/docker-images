FROM --platform=linux/amd64 nvidia/cuda:12.1.1-devel-ubuntu22.04

# fix tzdata
ENV TZ=Etc/UTC
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install libpq-dev libprotobuf-dev protobuf-compiler cmake build-essential pkg-config curl wget python3-full python3-pip git-all htop curl vim -y

RUN python3 -m pip install --upgrade pip
# https://github.com/yaml/pyyaml/issues/724
RUN python3 -m pip install --no-build-isolation pyyaml==5.4.1
RUN python3 -m pip install autotrain-advanced[base]
RUN python3 -m pip install sentencepiece
RUN python3 -m pip install transformers[all]
RUN python3 -m pip install langchain_openai langchain_huggingface
RUN python3 -m pip install flash-attn --no-build-isolation
RUN python3 -m pip install wandb

RUN date -u > /docker-build-time.txt
RUN echo "builder: GitHub Actions" >> /docker-build.txt
RUN echo "base: nvidia/cuda:12.1.1-devel-ubuntu22.04" >> /docker-build.txt
