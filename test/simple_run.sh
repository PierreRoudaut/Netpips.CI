#!/bin/bash

script_name=`basename "$0"`

if [ $# -ne 1 ]; then
    echo "./$script_name [TEST_PROJECT_PATH]"
    exit 1
fi

path=$1

dotnet test $path --filter "TestCategory!=Filebot&TestCategory!=ThirdParty"
