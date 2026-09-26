#!/usr/bin/env bash
# 最新の IG Publisher を input-cache/publisher.jar にダウンロードする。
set -euo pipefail
cd "$(dirname "$0")"
mkdir -p input-cache
curl -fsSL https://github.com/HL7/fhir-ig-publisher/releases/latest/download/publisher.jar -o input-cache/publisher.jar
ls -la input-cache/publisher.jar
