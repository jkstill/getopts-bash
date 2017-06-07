#!/bin/bash 

# includes long option names

FLAG_A='off'
VALUE_B='b'
logFile='mylogfile.log'

function usage {
	cat <<-USAGE
 usage:
 -a turn on a - default is $FLAG_A
 -b set value of b - default is  $VALUE_B
 --logfile name of logfile - default is $logFile
USAGE
}

#set -v

# the '-:' at the end allow to process long options
# these MUST be specified with --option

while getopts ab:-: arg
do
	case $arg in
		a) FLAG_A='on'
			;;
		b) VALUE_B=$OPTARG
			;;
		-) 
			case $OPTARG in
				logfile) 
					val="${!OPTIND}"; OPTIND=$(( $OPTIND + 1 ))
					#echo "Parsing option: '--${OPTARG}', value: '${val}'" >&2;
					logFile=$val
					;;
				*)
					val="${!OPTIND}"; OPTIND=$(( $OPTIND + 1 ))
					echo "$OPTARG not known"
					echo "Parsing option: '--${OPTARG}', value: '${val}'" >&2;
					usage; exit 1
					;;
			esac;;
		*) echo "argument not known"; usage; exit 1;
	esac

done

echo '========================'
echo A: $FLAG_A
echo VALUE B: $VALUE_B
echo logFile: $logFile

