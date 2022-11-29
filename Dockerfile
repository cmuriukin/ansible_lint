#FROM   registry.access.redhat.com/ubi8/ubi:latest
FROM    redhat/ubi9
LABEL   maintainer="Harry"
ENV     container=docker

ENV pip_packages "ansible"

# Silence subscription messages.
RUN echo "enabled=0" >> /etc/yum/pluginconf.d/subscription-manager.conf

# Install systemd
RUN     yum -y update; yum clean all; \
        (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
        rm -f /lib/systemd/system/multi-user.target.wants/*;\
        rm -f /etc/systemd/system/*.wants/*;\
        rm -f /lib/systemd/system/local-fs.target.wants/*; \
        rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
        rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
        rm -f /lib/systemd/system/basic.target.wants/*;\
        rm -f /lib/systemd/system/anaconda.target.wants/*;

# Install requirements.
RUN     yum -y update \
        && yum -y install \
         sudo \
         git \
         which \
         hostname \
         python3-pip \
        && yum clean all

# Install Ansible via Pip.
RUN     pip3  install $pip_packages ansible-lint

# Disable requiretty.
RUN     sed -i -e 's/^\(Defaults\s*requiretty\)/#--- \1/'  /etc/sudoers

# Install Ansible inventory file.
RUN     mkdir -p /etc/ansible
RUN     echo -e '[local]\nlocalhost ansible_connection=local' > /etc/ansible/hosts


# # Base Image
# FROM    ubuntu
# # Any info about the image
# LABEL   Maintainer="Harry"
# # Install git
# RUN     apt update -y --fix-missing && \
#     apt install -y software-properties-common && \
#     add-apt-repository ppa:git-core/ppa && \
#     apt update -y && \
#     apt install -y git
# # Install Ansible
# RUN     apt update -y && \
#     apt install -y python3-pip && \
#     pip3 install ansible
# # Install ansible-lint
# RUN     apt update -y && \
#     pip3 install ansible-lint

