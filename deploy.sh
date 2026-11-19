#!/usr/bin/env bash
if [ $# -ne 3 ]; then
  echo "사용법: $0 <서비스명> <태그 변수명> <태그>" >&2
  exit 1
fi

set -euo pipefail

SERVICE="$1"
TAG_KEY="$2"
TAG="$3"

cd "$(dirname "$0")"

sed -i "s/^${TAG_KEY}=.*/${TAG_KEY}=${TAG}/" .env

docker compose pull "$SERVICE"
docker compose up -d "$SERVICE"
docker image prune -f
docker compose ps