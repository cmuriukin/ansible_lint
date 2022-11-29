FROM ubuntu
LABEL Maintainer="Harry"
RUN apt update && \
    apt install python3-pip && \
    pip3 install ansible
# RUN apt update && \
#     apt install -y gcc python-dev libkrb5-dev && \
#     apt install python3-pip -y && \
#     pip3 install --upgrade pip && \
#     pip3 install --upgrade virtualenv && \
#     pip3 install pywinrm[kerberos] && \
#     apt install krb5-user -y && \ 
#     pip3 install pywinrm && \
#     pip3 install ansible
RUN	apt update && \
	pip3 install ansible-lint
