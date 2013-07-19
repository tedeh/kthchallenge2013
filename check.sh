#!/bin/sh


# Checks if a solution is correct
# First argument is the directory where the solution and the data files are stored

DIR=`dirname $0`/$1
BIN=$DIR/solution
DATA=$DIR/data

# Check if binary exists
if ! [[ -x $BIN ]]
then
  echo "Solution file $BIN does not exist or is not an executable!"
  exit -1
fi

# Check if data directory has been linked
if ! [[ -d $DIR ]]
then
  echo "Data directory $DIR does not exist!"
  exit -1
fi

DATA_INPUT=`find -L $DATA | grep "in$"`

TOTAL_COUNTER=0
CORRECT_COUNTER=0

for DATA_INPUT_FILE in $DATA_INPUT
do
  ANSWER=`$BIN < $DATA_INPUT_FILE`
  DATA_ANSWER_FILE=$DATA/`basename -s ".in" $DATA_INPUT_FILE`.ans
  CORRECT_ANSWER=`cat $DATA_ANSWER_FILE`

  MD5_CORRECT=`echo -n $CORRECT_ANSWER | md5`
  MD5_ATTEMPT=`echo -n $ANSWER | md5`

  if [[ $MD5_CORRECT = $MD5_ATTEMPT ]]
  then
    MD5_IS_EQ="OK"
    CORRECT_COUNTER=$[CORRECT_COUNTER + 1]
  else
    MD5_IS_EQ="NOT OK"
  fi

  #MD5_IS_EQ=$(( $MD5_CORRECT == $MD5_ATTEMPT ? "OK" : "NOT OK" ))

  TOTAL_COUNTER=$[TOTAL_COUNTER + 1]

  echo "$DATA_INPUT_FILE -> $MD5_CORRECT - $MD5_ATTEMPT - $MD5_IS_EQ"
done

echo "$CORRECT_COUNTER/$TOTAL_COUNTER OK"
