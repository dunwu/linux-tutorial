#!/usr/bin/env bash

for FILE in $HOME/; do
  mv "$FILE" "./"
  chmod +x "./${FILE}"
done
