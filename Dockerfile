FROM amazonlinux:2023

ARG OUT=/root/layers
ARG NODE_VERSION=20

# set up container
RUN yum -y update \
&& yum -y groupinstall "Development Tools" \
&& curl --silent --location https://rpm.nodesource.com/setup_${NODE_VERSION}.x | bash - \
&& yum install -y \
	nodejs

# will be created and become working dir
WORKDIR $OUT/nodejs

RUN npm install --build-from-source \
bcrypt@latest

WORKDIR $OUT

RUN ls

RUN zip -r -9 node${NODE_VERSION}_bcrypt_layer.zip nodejs