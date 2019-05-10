#!/bin/bash
# testing STDERR messages

echo "This is an error " >&2
echo "This is another error"
echo "This is also an error" >&2
