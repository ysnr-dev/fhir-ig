#!/usr/bin/env bash
# 公開レジストリに無い依存パッケージ(JP Core 1.2.0 / jpfhir-terminology 1.4.0)を
# FHIR パッケージキャッシュ(~/.fhir/packages)に展開する。SUSHI と IG Publisher が同じキャッシュを読む。
set -euo pipefail

CACHE="${FHIR_PACKAGE_CACHE:-$HOME/.fhir/packages}"
mkdir -p "$CACHE"

# install_pkg <name> <version> <url>
install_pkg() {
  local dir="$CACHE/$1#$2"
  if [ -f "$dir/package/package.json" ]; then
    echo "exists: $dir"
    return
  fi
  local tmp
  tmp="$(mktemp -d)"
  echo "downloading $3"
  curl -fsSL "$3" -o "$tmp/pkg.tgz"
  mkdir -p "$dir"
  tar -xzf "$tmp/pkg.tgz" -C "$dir"
  if [ ! -f "$dir/package/package.json" ]; then
    mkdir -p "$dir/package"
    find "$dir" -maxdepth 1 -mindepth 1 ! -name package -exec mv {} "$dir/package/" \;
  fi
  rm -rf "$tmp"
  echo "installed: $dir"
}

# package.json の name とキャッシュのフォルダ名を揃え、url(IG Publisher が外部リンクに使う)を公開 URL にする。
# fix_pkg <name> <version> [<url>]
fix_pkg() {
  local file="$CACHE/$1#$2/package/package.json"
  python3 - "$file" "$1" "${3:-}" <<'PY'
import json, sys
path, name, url = sys.argv[1], sys.argv[2], sys.argv[3]
with open(path, encoding="utf-8") as f:
    data = json.load(f)
changed = False
if data.get("name") != name:
    data["name"] = name; changed = True
if url and data.get("url") != url:
    data["url"] = url; changed = True
if changed:
    with open(path, "w", encoding="utf-8") as f:
        json.dump(data, f, ensure_ascii=False, indent=2)
    print(f"fixed: {path} (name={name}, url={url or data.get('url')})")
PY
}

install_pkg jpfhir.jp.core 1.2.0 https://jpfhir.jp/fhir/core/1.2.0/package.tgz
fix_pkg jpfhir.jp.core 1.2.0 https://jpfhir.jp/fhir/core/1.2.0
install_pkg jpfhir-terminology 1.4.0 https://jpfhir.jp/fhir/core/terminology/jpfhir-terminology.r4-1.4.0.tgz
install_pkg jpfhir-terminology.r4 1.4.0 https://jpfhir.jp/fhir/core/terminology/jpfhir-terminology.r4-1.4.0.tgz
fix_pkg jpfhir-terminology.r4 1.4.0
