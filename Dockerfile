FROM ubuntu:22.04

# Set environment variables to avoid user interaction during installation
ENV DEBIAN_FRONTEND=noninteractive

# Update the base system and install prerequisites
RUN apt-get update && apt-get install -y \
  curl \
  wget \
  gnupg \
  git \
  software-properties-common \
  apt-transport-https \
  unzip \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# Install kubectl
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" \
  && chmod +x kubectl \
  && mkdir -p ~/.local/bin \
  && mv ./kubectl ~/.local/bin/kubectl \
  && echo 'export PATH=$PATH:~/.local/bin' >> ~/.bashrc

# Install Terraform
RUN wget https://releases.hashicorp.com/terraform/1.0.9/terraform_1.0.9_linux_amd64.zip \
  && unzip terraform_1.0.9_linux_amd64.zip \
  && mkdir -p ~/.local/bin \
  && mv terraform ~/.local/bin/terraform \
  && echo 'export PATH=$PATH:~/.local/bin' >> ~/.bashrc

# Install Helm
RUN curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 \
  && chmod 700 get_helm.sh \
  && ./get_helm.sh

# Install k9s
RUN curl -LO https://github.com/derailed/k9s/releases/download/v0.32.7/k9s_linux_amd64.tar.gz \
  && tar -xvf k9s_linux_amd64.tar.gz \
  && mv k9s ~/.local/bin/k9s \
  && echo 'export PATH=$PATH:~/.local/bin' >> ~/.bashrc

# Cleanup
RUN rm -rf k9s_linux_amd64.tar.gz get_helm.sh terraform_1.0.9_linux_amd64.zip
RUN apt-get clean

# Set default entry point
CMD ["bash"]