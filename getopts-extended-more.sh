#!/bin/bash

# extended bash getopts

function usage {
	cat <<-USAGE

both long and short options may be used

 usage:
 --opt-a -a 
	 option a requires an argument

 --obt-b -b
	 option b requires an argument

 --opt-c -c
    option c - no argument

 --help -h
    help

This version allows for parameters that appear on the command line and should not be processed.

For instance you may use a script as a driver to setup and execute a program that has its own parameters.

ex:

  $0 --opt-a Aopt --opt-b optBarg -c someprogram -opt1 -opt2 filename -op3 someparm

USAGE
}

optA='default'
optB='default' 
optC=0  # -c --opt-c does not take an argument

#set -v

# the '-:' at the end allow to process long options
# these MUST be specified with --option

shiftOut=0

# options that take an argument require 2 shifts

while getopts ha:b:c-: arg
do
	case $arg in
		a) optA=$OPTARG;(( shiftOut+=2 ));;
		b) optB=$OPTARG;(( shiftOut+=2 ));;
		c) optC=1;(( shiftOut++ ));;
		h) usage;exit 0;;
		-)
			case $OPTARG in
				opt-a)
					val="${!OPTIND}"; OPTIND=$(( $OPTIND + 1 ))
					#echo "Parsing option: '--${OPTARG}', value: '${val}'" >&2;
					optA=$val
					(( shiftOut+=2 ))
					;;
				opt-b)
					val="${!OPTIND}"; OPTIND=$(( $OPTIND + 1 ))
					#echo "Parsing option: '--${OPTARG}', value: '${val}'" >&2;
					optB=$val
					(( shiftOut+=2 ))
					;;
				opt-c)
					val="${!OPTIND}"; OPTIND=$(( $OPTIND + 1 ))
					#echo "Parsing option: '--${OPTARG}', value: '${val}'" >&2;
					optC=1
					(( shiftOut++ ))
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
echo c: $optC

echo ARGS Before: $*

while [[ $shiftOut -gt 0 ]]
do
	(( shiftOut-- ))
	shift;
done

echo ARGS After : $*

