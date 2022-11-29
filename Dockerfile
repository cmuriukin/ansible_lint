# Base Image
FROM    ubuntu
# Any info about the image
LABEL   Maintainer="Harry"
# Install git
RUN     apt update -y --fix-missing && \
    apt install -y software-properties-common && \
    add-apt-repository ppa:git-core/ppa && \
    apt update -y && \
    apt install -y git
# Install Ansible
RUN     apt update -y && \
    apt install -y python3-pip && \
    pip3 install ansible
# Install ansible-lint
RUN     apt update -y && \
    pip3 install ansible-lint

