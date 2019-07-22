declare -i INDEX=0 \
  && while true; \
    do INDEX_BODY=$(curl --show-error --location --fail --retry 3 \
      https://api.github.com/repos/tj/n/releases | \
      jq --argjson index "$INDEX" '.[$index]') \
      && if [[ $(echo "$INDEX_BODY" | grep -v '"draft": true' && echo "$INDEX_BODY" grep -v '"prerelease": true') ]]; then \
      	INDEX_VERSION=$(echo "$INDEX_BODY" | jq '.tag_name') \
        && N_VERSION="${INDEX_VERSION:1:$((${#INDEX_VERSION} - 1 - 1))}" \
        && break; \
      else \
        INDEX=$((INDEX + 1)); \
      fi; \
    done && echo "$N_VERSION"
