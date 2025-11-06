FROM --platform=linux/amd64 nvidia/cuda:12.4.1-cudnn-devel-ubuntu22.04

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
ENV PIP_EXTRA_INDEX_URL="https://download.pytorch.org/whl/cu124"

RUN uv pip install nvitop
RUN uv pip install torch==2.6.0 transformers[torch,sklearn,retrieval,sentencepiece,accelerate,tokenizers,hub-kernels,serving,vision,chat_template]>=4.57.1
RUN uv pip install pandas numpy
RUN uv pip install "langchain<1" "langchain-core<1" langchain-openai langchain-huggingface langchain-text-splitters langsmith
RUN uv pip install bitsandbytes
RUN uv pip install setuptools
RUN uv pip install https://github.com/TURX/flash-attention-prebuild-wheels/releases/download/v0.0.4/flash_attn-2.8.3-cp310-cp310-linux_x86_64.whl
RUN uv pip install https://github.com/TURX/flash-attention-prebuild-wheels/releases/download/v0.0.4/flash_attn_3-3.0.0b1-cp39-abi3-linux_x86_64.whl

RUN uv pip install wandb
RUN uv pip install trl peft torcheval einops
RUN uv pip install unsloth
RUN uv pip install flashinfer-python flashinfer-cubin
RUN uv pip install xformers
RUN uv pip install vllm --torch-backend=cu124 --no-build-isolation

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
RUN echo "base: nvidia/cuda:12.4.1-cudnn-devel-ubuntu22.04" >> /docker-build.txt
