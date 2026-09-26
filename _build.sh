#!/usr/bin/env bash
# SUSHI → IG Publisher の順にビルドする。Docker コンテナ内と GitHub Actions で共用。
# 追加引数はそのまま IG Publisher に渡す。
set -euo pipefail
cd "$(dirname "$0")"

if command -v sushi >/dev/null 2>&1; then
  sushi .
else
  npx --yes -p fsh-sushi sushi .
fi

[ -f input-cache/publisher.jar ] || ./_updatepublisher.sh

java -Xmx"${IG_HEAP:-4g}" \
  -Duser.language=ja -Duser.country=JP -Djava.awt.headless=true \
  -jar input-cache/publisher.jar -ig ig.ini -tx n/a "$@"
