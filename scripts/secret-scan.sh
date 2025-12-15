#!/usr/bin/env sh
set -e
echo "Running secret-scan..."
grep -RIn --binary-files=without-match -E "BEGIN (OPENSSH|RSA) PRIVATE KEY|-----BEGIN PRIVATE KEY-----|root_token|SECRET_ID=|ROLE_ID=|AWS_SECRET_ACCESS_KEY|AKIA[0-9A-Z]{16}" . || true
echo "secret-scan complete"
