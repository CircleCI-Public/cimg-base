# The Node.js variant of the base image.
FROM cimg/base:edge

LABEL maintainer="CircleCI Community & Partner Engineering Team <community-partner@circleci.com>"

# Set default shell for building image
SHELL ["/bin/bash", "-exo", "pipefail", "-c"]

# Install NVM
RUN NVM_VERSION=$(curl --show-error --location --fail --retry 3 \
  https://api.github.com/repos/nvm-sh/nvm/releases/latest | \
  jq '.tag_name' | sed -E 's/"//g') \
  # extract latest version from GitHub releases API
  && curl -o- "https://raw.githubusercontent.com/nvm-sh/nvm/$NVM_VERSION/install.sh" | bash \
	&& source ~/.nvm/nvm.sh && nvm install --lts \
	&& export NVM_VERSION

ENV NVM_DIR $HOME/.nvm

# Verify NVM
RUN command -v nvm d\
	&& nvm --version | grep "$NVM_VERSION"

# Add node and npm to path so the commands are available
ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH

# Set default shell for users
SHELL ["/bin/bash", "-c"]
