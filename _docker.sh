#!/usr/bin/env bash
# ホストに Java 17+ が無くてもビルドできるように、hl7fhir/ig-publisher-base コンテナで _build.sh を実行する。
#
# バインドマウント上で IG Publisher を動かすと(Docker Desktop for Mac では)数万ファイルの書き込みが
# 極端に遅いので、リポジトリをコンテナ内の作業ボリュームにコピーしてビルドし、output/ だけホストに書き戻す。
# 作業ディレクトリはコンテナのファイルシステム上(実行ごとに作り直す)。パッケージキャッシュ(~/.fhir)と
# ホストの input-cache/publisher.jar は再実行のために使い回す。
set -euo pipefail
cd "$(dirname "$0")"

./_installdeps.sh

IMAGE="${IG_PUBLISHER_IMAGE:-hl7fhir/ig-publisher-base:latest}"
# イメージの作業ユーザー(publisher)のホーム。イメージを変えたときは IG_CONTAINER_HOME で上書きする。
CONTAINER_HOME="${IG_CONTAINER_HOME:-/home/publisher}"
# 端末から実行したときだけ -t を付ける(バックグラウンド実行で固まらないように)
TTY_FLAG=""
[ -t 0 ] && TTY_FLAG="-t"

docker run --rm $TTY_FLAG \
  -v "$PWD":/src \
  -v "$HOME/.fhir":"$CONTAINER_HOME/.fhir" \
  -e IG_HEAP="${IG_HEAP:-3g}" \
  -e IG_ARGS="$*" \
  "$IMAGE" \
  bash -c '
    set -euo pipefail
    WORK="$HOME/work/ig"
    mkdir -p "$WORK"
    # ホストに publisher.jar があれば使い回す(無ければ後で _updatepublisher.sh が取る)
    if [ -f /src/input-cache/publisher.jar ]; then mkdir -p "$WORK/input-cache"; cp /src/input-cache/publisher.jar "$WORK/input-cache/"; fi
    # ソースを作業ディレクトリへ(生成物とキャッシュは除く。消えたファイルも反映する)
    cd /src
    tar --exclude=./output --exclude=./temp --exclude=./template --exclude=./input-cache \
        --exclude=./fsh-generated --exclude=./translations --exclude=./.git --exclude=./node_modules \
        -cf - . | (cd "$WORK" && find . -mindepth 1 -maxdepth 1 \
          ! -name output ! -name temp ! -name template ! -name input-cache ! -name translations \
          -exec rm -rf {} + && tar -xf -)
    cd "$WORK"
    if [ ! -f input-cache/publisher.jar ]; then ./_updatepublisher.sh; mkdir -p /src/input-cache; cp input-cache/publisher.jar /src/input-cache/; fi
    rm -rf output
    ./_build.sh $IG_ARGS
    rm -rf /src/output
    cp -r output /src/output
  '
