#!/bin/sh
n=-1
c=0
if [ -n "$3" ]
then
   n=$3
fi

while [ $n -ne $c ]
do
   WAIT=$(shuf -i $1-$2 -n 1)
   sleep $(echo "scale=4; $WAIT/1000" | bc)
   I=$(shuf -i 1-4 -n 1)
   D=`date -Iseconds`
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
   if[ -z "${JSON}" ]
   then
       echo "$D $level $msg"
   else
       echo "{\"time\":\"$D\",\"level\":\"$level\",\"message\":\"$msg\"}"
   fi
   c=$(( c+1 ))
done
