FROM --platform=linux/amd64 nvidia/cuda:12.1.0-cudnn8-runtime-ubuntu22.04
ADD requirements.txt /requirements.txt
RUN apt-get update && apt-get install python3 python3-pip htop curl vim -y
RUN pip install -r /requirements.txt
RUN date -u > /docker-build-time.txt
