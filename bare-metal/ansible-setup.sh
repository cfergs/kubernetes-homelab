#!/bin/bash

# required for WSL2

ansiblePreReqs() {
  echo "*** START: ansible pre-requirements check ***"

  sudo apt-get update
  declare -a packages=(python3-pip python3-venv)

  echo "Checking Packages Installed:"
  for package in "${packages[@]}"
  do
      if [[ ! $(apt --installed list 2>/dev/null | grep $package) = *installed* ]]; then
        echo "$package: Missing; Installing"
        sudo apt install -y $package
        if [ $? -ne 0 ]; then
          echo "ERROR Installing $package. Exiting Script"
          exit 1
        fi
      else
        echo "$package: Installed"
      fi
  done

  echo "*** FINISH: ansible pre-requirements check ***"
}

ansibleSetup() {
  echo "*** START: ansible initialise step ***"
  rm -rf .venv
  python3 -m venv .venv
  source .venv/bin/activate && pip3 install wheel #wheel required BEFORE installing requirements
  pip install -r requirements-frozen.txt

  # role pre-reqs
  ansible-galaxy install -r requirements.yml

  echo "*** FINISH: ansible initialise step ***"
}

ansiblePreReqs
ansibleSetup