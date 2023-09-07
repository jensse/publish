#!/usr/bin/env bash
marktag="9.9.0"

function summary(){
  echo "Summary: installing mark version; ${1} testing..."
  echo $(bin/mark --version)
}

function installMark(){
  tag=${1}
  wget https://github.com/kovetskiy/mark/releases/download/${tag}/mark_Linux_x86_64.tar.gz
  tar -xzvf filename.tar.gz -C bin/
  chmod 755 bin/mark
}

installMark ${marktag}
summary ${marktag}

