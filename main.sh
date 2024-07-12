#!/bin/bash

while true; do

# Load configuration and functions
SELF_HOME="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Load configuration and functions
source "$SELF_HOME/config.sh"
source "$SELF_HOME/list.sh"
source "$SELF_HOME/enable.sh"
source "$SELF_HOME/disable.sh"
source "$SELF_HOME/edit.sh"
source "$SELF_HOME/remove.sh"
source "$SELF_HOME/add.sh"
list_configs
source "$SELF_HOME/choice.sh"

done
