#!/bin/bash

dvm_error() {
  echo "$@"
  exit 1
}

# shellcheck disable=SC1091
\. ./dvm.sh

# Set and check current version
dvm use v1.14.0 || dvm_error "[ERR] 'dvm use v1.14.0' failed"
dvm current | grep "v1.14.0" || dvm_error "[ERR] current version should be v1.14.0"

# Uninstall by current
dvm uninstall current || dvm_error "[ERR] 'dvm uninstall current' failed"
[ -f "$DVM_DIR/versions/v1.14.0/deno" ] && dvm_error "[ERR] deno v1.14.0 should be uninstalled"

# Install deno v1.14.0 again and set alias name 'default' to it
dvm install v1.14.0
dvm alias default v1.14.0 || dvm_error "[ERR] 'dvm alias default v1.14.0' failed"

# Uninstall by alias name
dvm uninstall default || dvm_error "[ERR] 'dvm uninstall default' failed"
[ -f "$DVM_DIR/versions/v1.14.0/deno" ] && dvm_error "[ERR] deno v1.14.0 should be uninstalled"

# Install deno v1.14.0 again
dvm install v1.14.0

# Uninstall by version
dvm uninstall v1.14.0 || dvm_error "[ERR] 'dvm uninstall v1.14.0' failed"
[ -f "$DVM_DIR/versions/v1.14.0/deno" ] && dvm_error "[ERR] deno v1.14.0 should be uninstalled"
