#!/usr/bin/env bash

aws cloudformation deploy \
  --template-file infra.yml \
  --stack-name "capstone-infra" \
  --parameter-overrides ID="capstone" \
  --tags project="capstone"