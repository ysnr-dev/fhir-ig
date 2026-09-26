#!/usr/bin/env bash
# ホストに Java 17+ が無くてもビルドできるように、hl7fhir/ig-publisher-base コンテナで _build.sh を実行する。
# パッケージキャッシュ(~/.fhir)はホストと共有する。
set -euo pipefail
cd "$(dirname "$0")"

./_installdeps.sh

IMAGE="${IG_PUBLISHER_IMAGE:-hl7fhir/ig-publisher-base:latest}"
# イメージの作業ユーザー(publisher)のホーム。イメージを変えたときは IG_CONTAINER_HOME で上書きする。
CONTAINER_HOME="${IG_CONTAINER_HOME:-/home/publisher}"

docker run --rm ${DOCKER_TTY:--t} \
  -v "$PWD":"$CONTAINER_HOME/ig" \
  -v "$HOME/.fhir":"$CONTAINER_HOME/.fhir" \
  -e IG_HEAP="${IG_HEAP:-4g}" \
  -w "$CONTAINER_HOME/ig" \
  "$IMAGE" \
  bash -c "./_updatepublisher.sh && ./_build.sh $*"
