#!/bin/bash

echo "Gitlab Runner is installing"

if [ $(command -v gitlab-runner) ]; then
  echo "GitLab Runner is already installed."
  exit 0
fi

curl -L https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.deb.sh | sudo bash
sudo apt-get install gitlab-runner

sudo gitlab-runner register

sudo systemctl start gitlab-runner
sudo systemctl enable gitlab-runner

echo "GitLab Runner installation complete."