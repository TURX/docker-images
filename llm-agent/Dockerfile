FROM --platform=linux/amd64 nvidia/cuda:12.6.3-devel-ubuntu24.04

# fix tzdata
ENV TZ=Etc/UTC
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install libpq-dev libprotobuf-dev protobuf-compiler cmake build-essential pkg-config curl wget git-all htop curl vim -y

RUN apt-get update && apt-get install -y \
    ffmpeg \
    libavformat-dev \
    libavcodec-dev \
    libavdevice-dev \
    libavutil-dev \
    libavfilter-dev \
    libswscale-dev \
    libswresample-dev \
    -y

COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/
RUN uv venv /opt/venv --python 3.11
ENV UV_COMPILE_BYTECODE=1
ENV UV_LINK_MODE=copy
ENV VIRTUAL_ENV=/opt/venv
ENV PATH="/opt/venv/bin:$PATH"

RUN uv pip install nvitop
RUN uv pip install sentencepiece
RUN uv pip install transformers[all]>=4.57.1
RUN uv pip install langchain langchain-core langchain-openai langchain-huggingface
RUN uv pip install --upgrade bitsandbytes
RUN uv pip install flash-attn --no-build-isolation
RUN uv pip install wandb
RUN uv pip install trl peft torcheval einops
RUN uv pip install unsloth

# group_level_summary template
RUN uv pip install python-docx
RUN uv pip install cairosvg
RUN uv pip install seaborn

# rouge
RUN uv pip install nltk
RUN uv pip install absl-py
RUN uv pip install rouge_score

RUN date -u > /docker-build-time.txt
RUN echo "builder: GitHub Actions" >> /docker-build.txt
RUN echo "base: nvidia/cuda:12.6.3-devel-ubuntu24.04" >> /docker-build.txt
