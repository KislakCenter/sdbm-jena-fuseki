#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

echo $SCRIPT_DIR
config_file=$SCRIPT_DIR/.sdbmjfrc
data_loc=$SCRIPT_DIR/TDB2

if [[ ! -d $data_loc ]]
then
    echo "ERROR: Data directory not present: '$data_loc'"
fi

fuseki-server --loc=TDB2 /sdbm
