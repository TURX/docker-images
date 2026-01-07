FROM --platform=linux/amd64 nvidia/cuda:12.4.1-cudnn-devel-ubuntu22.04

# fix tzdata
ENV TZ=Etc/UTC
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install python3-full python3-dev python3-pip libpq-dev libprotobuf-dev protobuf-compiler build-essential pkg-config curl wget git-all htop curl vim -y

COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/
RUN uv venv /venv --relocatable
ENV MAX_JOBS=2
ENV NVCC_THREADS=1
ENV UV_COMPILE_BYTECODE=1
ENV UV_LINK_MODE=copy
ENV VIRTUAL_ENV=/venv
ENV PATH="/venv/bin:$PATH"
ENV PIP_EXTRA_INDEX_URL="https://download.pytorch.org/whl/cu124"
ENV UV_TORCH_BACKEND=cu124
ENV FLASH_INFER_VERSION=0.5.3
ENV TORCH_VERSION=2.9.1
ENV VLLM_VERSION=0.13.0
ENV VLLM_USE_PRECOMPILED=1

RUN uv pip install setuptools packaging psutil wheel pip build setuptools-scm cmake pyyaml typing-extensions six

RUN uv pip install nvitop

RUN git clone --recursive --depth 1 --branch v${TORCH_VERSION} http://github.com/pytorch/pytorch /pytorch
RUN cd /pytorch && PYTORCH_BUILD_VERSION=${TORCH_VERSION} PYTORCH_BUILD_NUMBER=1 python setup.py bdist_wheel
RUN cp /pytorch/dist/torch-*.whl /wheels/ && \
    uv pip install /pytorch/dist/torch-*.whl && \
    rm -rf /pytorch

RUN uv pip install transformers[torch,sklearn,retrieval,sentencepiece,accelerate,tokenizers,hub-kernels,serving,vision,chat_template]>=4.57.1 evaluate
RUN uv pip install pandas numpy
RUN uv pip install python-dotenv
RUN uv pip install "langchain<1" "langchain-core<1" langchain-openai langchain-huggingface langchain-text-splitters langsmith
RUN uv pip install bitsandbytes
RUN mkdir -p /wheels
RUN if [ "$(uname -m)" = "x86_64" ]; then \
      uv pip install https://github.com/TURX/flash-attention-prebuild-wheels/releases/download/v0.0.4/flash_attn-2.8.3-cp310-cp310-linux_x86_64.whl && \
      uv pip install https://github.com/TURX/flash-attention-prebuild-wheels/releases/download/v0.0.4/flash_attn_3-3.0.0b1-cp39-abi3-linux_x86_64.whl ; \
    fi

RUN uv pip install wandb
RUN uv pip install trl peft torcheval einops
RUN uv pip install unsloth
RUN uv pip install nvidia-nvshmem-cu12
RUN uv pip install flashinfer-python flashinfer-cubin --no-build-isolation
RUN uv pip install xformers --no-build-isolation

# Build FlashInfer
RUN git clone --recursive --depth 1 https://github.com/flashinfer-ai/flashinfer.git -b v${FLASH_INFER_VERSION} /flash-infer
RUN uv pip install --force-reinstall --no-cache-dir flashinfer-python

WORKDIR /flash-infer/flashinfer-cubin
RUN python -m build --no-isolation --wheel
RUN mv dist/*.whl /wheels/

# WORKDIR /flash-infer/flashinfer-jit-cache
# ENV FLASHINFER_CUDA_ARCH_LIST="7.5 8.0 8.9 9.0"
# RUN python -m build --no-isolation --wheel
# RUN mv dist/*.whl /wheels/
# RUN rm -rf /flash-infer

# Build vLLM
RUN git clone --recursive --depth 1 https://github.com/vllm-project/vllm.git -b v${VLLM_VERSION} /vllm
WORKDIR /vllm
RUN python use_existing_torch.py \
    && python setup.py sdist bdist_wheel
RUN mv dist/*.whl /wheels/
RUN rm -rf /vllm

RUN uv pip install /wheels/*.whl

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
