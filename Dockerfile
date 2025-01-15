FROM ubuntu:22.04

# Set environment variables to avoid user interaction during installation
ENV DEBIAN_FRONTEND=noninteractive

# Update the base system and install prerequisites
RUN apt-get update && apt-get install -y \
  curl \
  wget \
  gnupg \
  sudo \
  git \
  openssh-server \
  software-properties-common \
  apt-transport-https \
  unzip \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* \
  && mkdir /var/run/sshd

# Install kubectl
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" \
  && chmod +x kubectl \
  && mv ./kubectl /usr/local/bin/kubectl

# Install Helm
RUN curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 \
  && chmod 700 get_helm.sh \
  && ./get_helm.sh

# Install k9s
RUN curl -LO https://github.com/derailed/k9s/releases/download/v0.32.7/k9s_linux_amd64.tar.gz \
  && tar -xvf k9s_linux_amd64.tar.gz \
  && mv k9s /usr/local/bin/k9s

# Add SSH user
RUN useradd -m -s /bin/bash -G sudo p4
RUN echo "p4:p4" | chpasswd
RUN echo "p4 ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
RUN sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
USER p4
WORKDIR /home/p4

# Start SSH
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]

# Cleanup
RUN rm -rf k9s_linux_amd64.tar.gz get_helm.sh

# Copy start script
COPY entrypoint.sh /home/p4/entrypoint.sh
RUN sudo chown p4:p4 /home/p4/entrypoint.sh
RUN sudo chmod +x /home/p4/entrypoint.sh

# Set default entry point
ENTRYPOINT ["/home/p4/entrypoint.sh"]
