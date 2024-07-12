#!/bin/bash

# Function to edit a configuration file
edit_config() {
    local config=$1
    gedit "$SITES_AVAILABLE/$config"
}
