#!/bin/bash

# required for WSL2 - Ubuntu

WslPreReqs() {
  echo "*** START: pre-requirements check ***"

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

  echo "*** FINISH: pre-requirements check ***"
}

FedoraPreReqs() {
  echo "*** START: pre-requirements check ***"

  if [ $(yum list installed | cut -f1 -d" " | grep --extended 'python3-pip' | wc -l) -eq 1 ]; then
    echo "pip3 installed";
  else
    echo "pip3 missing"
    sudo dnf install python3-pip -y
  fi

  echo "*** FINISH: pre-requirements check ***"
}

if [[ $(grep -i Microsoft /proc/version) ]]; then
  echo "Running Ubuntu on Windows"
  WslPreReqs
else
  if [[ $(cat /etc/fedora-release | echo $ID) -eq 'fedora' ]]; then
    echo "Running Fedora"
    FedoraPreReqs
  fi
fi
