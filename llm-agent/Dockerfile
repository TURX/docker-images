FROM --platform=linux/amd64 nvidia/cuda:12.6.3-devel-ubuntu24.04

# fix tzdata
ENV TZ=Etc/UTC
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install python3-full python3-dev python3-pip libpq-dev libprotobuf-dev protobuf-compiler cmake build-essential pkg-config curl wget git-all htop curl vim -y

COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/
RUN uv venv /venv --relocatable
ENV UV_COMPILE_BYTECODE=1
ENV UV_LINK_MODE=copy
ENV VIRTUAL_ENV=/venv
ENV PATH="/venv/bin:$PATH"
ENV PIP_EXTRA_INDEX_URL="https://download.pytorch.org/whl/cu126"

RUN uv pip install nvitop
RUN uv pip install torch==2.8.0 transformers[torch,sklearn,retrieval,sentencepiece,accelerate,tokenizers,hub-kernels,serving,vision,chat_template]>=4.57.1
RUN uv pip install langchain langchain-core langchain-openai langchain-huggingface
RUN uv pip install bitsandbytes
RUN uv pip install setuptools
RUN uv pip install https://github.com/Dao-AILab/flash-attention/releases/download/v2.8.3/flash_attn-2.8.3+cu12torch2.8cxx11abiFALSE-cp312-cp312-linux_x86_64.whl
RUN uv pip install flash_attn_3 --find-links https://windreamer.github.io/flash-attention3-wheels/cu126_torch280

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
