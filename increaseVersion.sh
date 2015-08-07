#!/bin/bash

node getNewestRelease.js

source env.sh .

git checkout master
git commit -am "Bumped version to ${NAME}"
if git checkout ${BRANCH} ; then
  echo 'yay'
else
  git checkout -b ${BRANCH} --track origin/${BRANCH}
fi
git merge master
git push
git checkout master
git push

source .secret.sh .

# Trigger by Source branch named staging
curl -H "Content-Type: application/json" --data '&#123;"source_type": "Branch", "source_name": "master"&#125;' -X POST https://registry.hub.docker.com/u/leipert/atom-apm/trigger/${SECRET}/

# Trigger by Source branch named staging
curl -H "Content-Type: application/json" --data $BRANCH_VERSION -X POST https://registry.hub.docker.com/u/leipert/atom-apm/trigger/${SECRET}/
