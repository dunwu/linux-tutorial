#!/usr/bin/env bash

echo -e "\n>>>>>>>>> install sdk"

curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk version
