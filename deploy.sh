#!/usr/bin/env bash
# 사용법: ./deploy.sh <서비스명> <태그 변수명> <태그>
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