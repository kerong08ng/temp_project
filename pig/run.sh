#!/usr/bin/env bash

if [[ `ls | grep log | wc -l` != 0 ]]; then
   rm *.log
fi

FILE_PATH='/home/thomas/workspace/learn_hadoop/project_data/testdata' #path to data directory
SCRIPT_PATH='/home/thomas/workspace/learn_hadoop/project_data/src/pig/main.pig' #path to pig script

INDEPENDENT_VAR='ActualElapsedTime' #field name of independent variable
DEPENDENT_VAR='AirTime' #field name of dependent variable
GROUP='Month' #group by what

pig \
-p filePath=$FILE_PATH \
-p independentVariable=$INDEPENDENT_VAR \
-p dependentVariable=$DEPENDENT_VAR \
-p groupBy=$GROUP \
-x local -4 nolog.conf $SCRIPT_PATH