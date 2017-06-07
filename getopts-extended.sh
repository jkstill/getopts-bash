#!/bin/bash

# extended bash getopts

function usage {
	cat <<-USAGE

both long and short options may be used

 usage:
 --opt-a -a 
	 option a

 --obt-b -b
	 option b

 --help -h
    help

USAGE
}

optA='default'
optB='default'

#set -v

# the '-:' at the end allow to process long options
# these MUST be specified with --option

while getopts ha:b:-: arg
do
	case $arg in
		a) optA=$OPTARG;;
		b) optB=$OPTARG;;
		h) usage;exit 0;;
		-)
			case $OPTARG in
				opt-a)
					val="${!OPTIND}"; OPTIND=$(( $OPTIND + 1 ))
					#echo "Parsing option: '--${OPTARG}', value: '${val}'" >&2;
					optA=$val
					;;
				opt-b)
					val="${!OPTIND}"; OPTIND=$(( $OPTIND + 1 ))
					#echo "Parsing option: '--${OPTARG}', value: '${val}'" >&2;
					optB=$val
					;;
				help) usage; exit 0;;
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


echo a: $optA
echo b: $optB



