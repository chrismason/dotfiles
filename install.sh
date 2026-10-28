#!/bin/bash

set -e

cd -- "$(dirname -- "${BASH_SOURCE[0]}")"

if [ -z "${CODESPACES:-}" ]; then
    source ./setup.osx.sh
else
    source ./setup.codespaces.sh
fi
