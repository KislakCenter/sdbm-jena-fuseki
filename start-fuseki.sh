#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

config_file=$SCRIPT_DIR/.sdbmjfrc
data_loc=$SCRIPT_DIR/TDB2

if [[ -f $config_file ]]
then
  source $config_file
else
    echo "WARNING: Config file not present: '$config_file'"
fi

if [[ ! -d $data_loc ]]
then
    echo "ERROR: Data directory not present: '$data_loc'"
fi

fuseki-server --config fuseki_config.ttl