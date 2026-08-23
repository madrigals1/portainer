#!/bin/sh
set -eu

# Create Portainer admin password file from ADMIN_PASSWORD env var
# This is needed because portainer image is distroless (no shell)
# and --admin-password-file requires a file, not env var directly

if [ -z "${ADMIN_PASSWORD:-}" ]; then
  echo "ERROR: ADMIN_PASSWORD is not set" >&2
  exit 1
fi

# Write password without trailing newline (portainer expects -n)
printf "%s" "$ADMIN_PASSWORD" > /run/secrets/portainer_password
chmod 400 /run/secrets/portainer_password
echo "Portainer admin password file created"
