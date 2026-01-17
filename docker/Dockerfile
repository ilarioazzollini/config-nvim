FROM ubuntu:24.04

# Docker build arguments
ARG NVIM_TAG=v0.11.5
ARG RUST_VERSION=1.92.0

# Environment variables
ENV HOME=/root

# Set working directory
WORKDIR ${HOME}

# Install packages without prompting the user to answer any questions
ENV DEBIAN_FRONTEND="noninteractive"

# Timezone and locale
ENV TZ="Europe/Rome"
RUN apt-get update && apt-get install -y tzdata locales && \
    rm -rf /var/lib/apt/lists/*
RUN locale-gen en_US en_US.UTF-8
RUN update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
ENV LANG=en_US.UTF-8

# Install neovim dependencies
RUN apt-get update && apt-get install -q -y \
    build-essential \
    git \
    ninja-build \
    gettext \
    cmake \
    curl \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Clone, build, and install neovim (stable) from sources
RUN git clone --depth 1 --branch ${NVIM_TAG} https://github.com/neovim/neovim.git
RUN cd ${HOME}/neovim && \
    make CMAKE_BUILD_TYPE=Release && \
    make install

# Install kickstart.nvim dependencies
RUN apt-get update && apt-get install -q -y \
    ripgrep \
    unzip \
    xclip \
    fd-find \
    && rm -rf /var/lib/apt/lists/*

# Install Lua + headers for LuaRocks
RUN apt-get update && apt-get install -y \
    lua5.1 \
    liblua5.1-0-dev \
    pkg-config \
    && rm -rf /var/lib/apt/lists/*

# Install LuaRocks
RUN wget https://luarocks.org/releases/luarocks-3.13.0.tar.gz && \
    tar zxpf luarocks-3.13.0.tar.gz && \
    cd luarocks-3.13.0 && \
    ./configure && make && make install && \
    luarocks install luasocket

# Install node (needed for tree-sitter-cli)
RUN apt-get update && apt-get install -y \
    nodejs \
    npm \
    && rm -rf /var/lib/apt/lists/*

# Install tree-sitter CLI
RUN npm install -g tree-sitter-cli

# copy the nvim config folder in the default location
# COPY ./nvim ${HOME}/.config/nvim

### RUST ###

# Install system dependencies required by rustup and common crates
RUN apt-get update && apt-get install -y \
    # build-essential \ ALREADY INSTALLED
    # curl \
    ca-certificates \
    # pkg-config \ ALREADY INSTALLED
    libssl-dev \
    # git \ ALREADY INSTALLED
    && rm -rf /var/lib/apt/lists/*

# Configure rustup
ENV RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    PATH=/usr/local/cargo/bin:$PATH

# Install Rust (stable) via rustup
# RUN curl https://sh.rustup.rs -sSf | sh -s -- -y --no-modify-path --default-toolchain stable
RUN curl https://sh.rustup.rs -sSf | sh -s -- \
    -y \
    --no-modify-path \
    --default-toolchain ${RUST_VERSION}

# Install additional Rust components
RUN rustup component add \
    rustfmt \
    clippy \
    rust-analyzer
