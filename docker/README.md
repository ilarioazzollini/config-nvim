# Dockerized Neovim

This folder is here for testing purposes. For simplicity and portability, we choose to rely on Docker. The starting image is `ubuntu:24.04`.

## Build the Docker image

First of all, let us choose a version of neovim to install. We will build from sources, therefore we need to find the corresponding tag on the official [neovim repo](https://github.com/neovim/neovim). For instance, let us choose [v0.11.5](https://github.com/neovim/neovim/tree/v0.11.5).

After having cloned this repo locally on our computer, let us navigate to the `config-nvim` folder (that is, the root folder of this repo) and:

```bash
cd config-nvim
export NVIM_TAG=v0.11.5
export RUST_VERSION=1.92.0
```

Now we can run:

```bash
docker build \
    --no-cache \
    --build-arg NVIM_TAG=${NVIM_TAG} \
    --build-arg RUST_VERSION=${RUST_VERSION} \
    -f docker/Dockerfile \
    -t neovim-test:latest \
    .
```

## Run the Docker container

We can run a container from the previously built image by running:

```bash
docker run \
    -it \
    --rm \
    --privileged \
    --network=host \
    -v ${PWD}/nvim:/root/.config/nvim \
    -v ${PWD}/hello_rust:/root/hello_rust \
    --name neovim-test-container \
    neovim-test:latest \
    bash
```

and from the container simply run `nvim` and start testing!

## Checkhealth

:checkhealth
