#!/usr/bin/env bash
echo "[mock-systemctl] $@"
if [[ "$1" == "restart" ]]; then
  echo "Mock restarting service: $2"
  exit 0
fi
if [[ "$1" == "status" ]]; then
  echo "Mock status: active (running)"
  exit 0
fi
