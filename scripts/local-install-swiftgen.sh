#!/usr/bin/env bash

# Function

function print_verbose() {
    if [ ${S_FLAG} -ne 1 ]; then
        echo "$1"
    fi
}

# Usage Text

USAGE=$(cat <<EOF
Usage:
    $(basename ${0}) [<options>] [install path]

Options:
    -h  help text
    -s  silent mode
EOF
)

# Arguments parse

S_FLAG=0
while getopts :hs OPT
do
    case $OPT in
        h)  echo "${USAGE}"
            exit 0
            ;;
        s)  S_FLAG=1
            ;;
        \?) echo "${USAGE}" 1>&2
            exit 1
            ;;
    esac
done

shift $((OPTIND - 1))

if [ $# != 1 ]; then
    echo "${USAGE}" 1>&2
    exit 1
fi
INSTALL_PATH=$1

# Install process

mkdir -p "${INSTALL_PATH}"

NAME="SwiftGen"
VERSION="6.5.1"
ZIP_URL="https://github.com/SwiftGen/SwiftGen/releases/download/${VERSION}/swiftgen-${VERSION}.zip"
BIN_PATH="${INSTALL_PATH}/bin/swiftgen"

STENCIL_VERSION="0.14.1"
STENCILSWIFTKIT_VERSION="2.8.0"
SWIFTGENKIT_VERSION="6.5.1"

VERSION_CMD="${BIN_PATH} --version"
EXPECTED_VERSION_FMT="SwiftGen v${VERSION} (Stencil v${STENCIL_VERSION}, StencilSwiftKit v${STENCILSWIFTKIT_VERSION}, SwiftGenKit v${SWIFTGENKIT_VERSION})"

if [ "$(${VERSION_CMD} 2>/dev/null)" != "${EXPECTED_VERSION_FMT}" ]; then
  print_verbose "${NAME} ${VERSION} not installed. Download and installing..."

  curl -fsSL "${ZIP_URL}" | bsdtar xf - -C "${INSTALL_PATH}"
  chmod 755 "${BIN_PATH}"

  print_verbose "${NAME} ${VERSION} installed."
else
  print_verbose "${NAME} ${VERSION} already installed." 
fi

echo "${BIN_PATH}"
