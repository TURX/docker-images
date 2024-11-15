FROM --platform=linux/amd64 nvidia/cuda:12.1.1-devel-ubuntu22.04
ADD requirements.txt /requirements.txt
RUN apt-get update && apt-get install python3 python3-pip python3-dev htop curl vim libpq-dev libprotobuf-dev protobuf-compiler cmake build-essential -y
# https://github.com/yaml/pyyaml/issues/724
RUN pip install --no-build-isolation pyyaml==6.0.2
RUN pip install -r /requirements.txt
RUN date -u > /docker-build-time.txt
RUN echo "builder: GitHub Actions" >> /docker-build.txt
RUN echo "base: nvidia/cuda:12.1.1-devel-ubuntu22.04" >> /docker-build.txt
