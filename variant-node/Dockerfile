# The Node.js variant of the base image.
FROM cimg/base:stable

LABEL maintainer="CircleCI Community & Partner Engineering Team <community-partner@circleci.com>"

ENV NVM_VERSION 0.34.0

RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v${NVM_VERSION}/install.sh | bash \
	&& source ~/.nvm/nvm.sh && nvm install --lts

ENV NVM_DIR $HOME/.nvm

# add node and npm to path so the commands are available
ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

#RUN source $NVM_DIR/nvm.sh && nvm install --lts
#RUN source $NVM_DIR/nvm.sh && nvm install --lts

# This matches the default CircleCI working directory.
WORKDIR /root/project
