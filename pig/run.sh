#!/usr/bin/env bash

if [[ `ls | grep log | wc -l` != 0 ]]; then
   rm *.log
fi

FILE_PATH='/home/thomas/workspace/learn_hadoop/project_data/testdata'
SCRIPT_PATH='/home/thomas/workspace/learn_hadoop/project_data/src/main.pig'

INDEPENDENT_VAR='ActualElapsedTime'
DEPENDENT_VAR='AirTime'
GROUP='Month'

pig \
-p filePath=$FILE_PATH \
-p independentVariable=$INDEPENDENT_VAR \
-p dependentVariable=$DEPENDENT_VAR \
-p groupBy=$GROUP \
-x local -4 nolog.conf $SCRIPT_PATH