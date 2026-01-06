FROM ubuntu:24.04

# Docker build arguments
ARG NVIM_TAG=v0.11.5

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

# copy the nvim config folder in the default location
COPY ./nvim ${HOME}/.config/nvim
