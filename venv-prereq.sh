#!/bin/bash

# required for WSL2 - Ubuntu

venvPreReqs() {
  echo "*** START: venv pre-requirements check ***"

  sudo apt-get update
  declare -a packages=(python3-pip python3-venv python3-testresources)

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

  echo "*** FINISH: venv pre-requirements check ***"
}

venvPreReqs
