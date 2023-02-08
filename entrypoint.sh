#!/bin/sh
n=-1
c=0
RANGE_MIN=100
RANGE_MAX=500

while [ $# -gt 0 ]
do
  key="$1"
  
  case ${key} in
    -r|--range)
    RANGE_MIN=$2
    shift # past argument
    RANGE_MAX=$2
    shift # past value
    ;;
    -c|--count)
    n=$2
    shift # past argument
    ;;
    -j|--json)
    JSON=1
    ;;
    -t|--timestamp)
    TIMESTAMP=1
    ;;
  esac
  shift # value
done

while [ $n -ne $c ]
do
   WAIT=$(shuf -i $RANGE_MIN-$RANGE_MAX -n 1)
   sleep $(echo "scale=4; $WAIT/1000" | bc)
   I=$(shuf -i 1-4 -n 1)
   if [ -z "${TIMESTAMP}" ]
   then
    D=`date -Iseconds`
   else
    D=`date +%s%3N` #millisecond timestamp
   fi
   case "$I" in
      "1") 
      msg="An error is usually an exception that has been caught and not handled."
      level="ERROR"
      ;;
      "2")
      msg="This is less important than debug log and is often used to provide context in the current task."
      level="INFO"
      ;;
      "3")
      msg="A warning that should be ignored is usually at this level and should be actionable."
      level="WARN"
      ;;
      "4") 
      msg="This is a debug log that shows a log that can be ignored."
      level="DEBUG"
      ;;
   esac
   if [ -z "${JSON}" ]
   then
       echo "$D $level $msg"
   else
       if [ -z "${TIMESTAMP}" ]
       then
         echo "{\"time\":\"$D\",\"level\":\"$level\",\"message\":\"$msg\"}"
       else
         echo "{\"timestamp\":\"$D\",\"level\":\"$level\",\"message\":\"$msg\"}"
       fi
   fi
   c=$(( c+1 ))
done
