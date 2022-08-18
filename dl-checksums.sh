#!/usr/bin/env sh
set -e
DIR=~/Downloads
MIRROR=https://github.com/stepchowfun/docuum/releases/download

dl()
{
    local app=$1
    local ver=$2
    local os=$3
    local arch=$4
    local dotexe=${5:-}
    local platform="${arch}-${os}"
    local url=$MIRROR/v$ver/${app}-${platform}${dotexe}
    local lfile=$DIR/${app}-${ver}-${platform}${dotexe}
    if [ ! -e $lfile ];
    then
        curl -sSLf -o $lfile $url
    fi
    printf "    # %s\n" $url
    printf "    %s: sha256:%s\n" $platform $(sha256sum $lfile | awk '{print $1}')
}

dl_ver() {
    local app=$1
    local ver=$2
    printf "  '%s':\n" $ver
    dl $app $ver apple-darwin x86_64
    dl $app $ver unknown-linux-gnu x86_64
    dl $app $ver unknown-linux-musl x86_64
    dl $app $ver pc-windows-msvc x86_64 .exe
}

dl_ver docuum ${1:-0.21.1}
