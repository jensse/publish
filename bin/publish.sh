#!/usr/bin/env bash
marktag="9.9.0"

function summary(){
  echo "Summary: installing mark version; ${1} testing..."
  echo $(bin/mark --version)
  echo $(env)
}

function installMark(){
  tag=${1}
  if [ -f "bin/mark"]l; then
    echo "bin/mark, exist"
  else
    wget https://github.com/kovetskiy/mark/releases/download/${tag}/mark_Linux_x86_64.tar.gz
    tar -xzvf mark_Linux_x86_64.tar.gz -C bin/
    chmod 755 bin/mark
  fi
}

function publishMd(){
  bin/mark --dry-run --username ${1} --password ${2} -b "${3}" -f src/test.md
}

installMark ${marktag}
summary ${marktag}
publishMd ${MUSER} ${MPASS} ${MURL}
