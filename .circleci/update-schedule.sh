#!/usr/bin/env bash

curl --location --request POST \
  "https://circleci.com/api/v2/project/gh/CircleCI-Public/cimg-base/schedule" \
  --header "Circle-Token: $CIRCLECI_TOKEN" \
  --header 'Content-Type: application/json' \
  --data-raw "$(cat schedule.json)"
