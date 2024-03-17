FROM --platform=linux/amd64 nvidia/cuda:12.1.1-devel-ubuntu22.04
ADD requirements.txt /tmp/requirements.txt
RUN apt-get update && apt install libprotobuf-dev protobuf-compiler cmake build-essential curl wget python3 python3-pip htop curl vim -y
ADD jumanpp.sh /tmp/jumanpp.sh
RUN sh /tmp/jumanpp.sh
RUN pip install -r /tmp/requirements.txt
RUN python3 -m unidic download
RUN date -u > /docker-build.txt
RUN echo "builder: GitHub Actions" >> /docker-build.txt
RUN echo "base: nvidia/cuda:12.1.1-devel-ubuntu22.04" >> /docker-build.txt
RUN echo "jumanpp: 2.0.0-rc4" >> /docker-build.txt
