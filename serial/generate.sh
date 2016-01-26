#!/bin/bash
# An SMBIOS generator for MacBook Air 7,x based on Hackintosh Vietnam tool

# Clean up the screen
clear
# Declarations
rule=CDFGHJKLMNPQRTVWXY12345678
chars=ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890
# Year is hard coded to P because it's an Early-2015 model
# Week range is C-R because it's an Early-2015 (March 9th - May 31th)
# Check it out: http://week-number.net/calendar-with-week-numbers-2015.html
week=CDFGHKLMNPQRSTUVWXY

# Generate a random (yet valid) serial number
week_letter=`echo ${week:$(($RANDOM%${#week})):1}`
function random_char { echo ${chars:$(($RANDOM%${#chars})):1}; }
function random_ending { gsort -R sn-endings.txt | head -n 1;  }
SN=C02P$week_letter$(random_char)$(random_char)$(random_char)$(random_ending)

serialNumberYear=$(echo $SN | cut -c 4)
case "$serialNumberYear" in
  C | D) manufactureYear=0;;
  F | G) manufactureYear=1;;
  H | J) manufactureYear=2;;
  K | L) manufactureYear=3;;
  M | N) manufactureYear=4;;
  P | Q) manufactureYear=5;;
  R | S) manufactureYear=6;;
  T | V) manufactureYear=7;;
  W | X) manufactureYear=8;;
  Y | Z) manufactureYear=9;;
  *)
    echo "Error: Invalid serial number (reason: invalid year)!"
    exit 128;;
esac

serialNumberYear=$(echo $SN | cut -c 4)
case "$serialNumberYear" in
  D | G | J | L | N | Q | S | V | X | Z) weekNumber=27;;
esac
serialNumberWeek=$(echo $SN | cut -c 5)
case "$serialNumberWeek" in
  [1-9]) ((weekNumber+=$serialNumberWeek));;
  C) ((weekNumber+=10));;
  D) ((weekNumber+=11));;
  F) ((weekNumber+=12));;
  G) ((weekNumber+=13));;
  H) ((weekNumber+=14));;
  K) ((weekNumber+=15));;
  L) ((weekNumber+=16));;
  M) ((weekNumber+=17));;
  N) ((weekNumber+=18));;
  P) ((weekNumber+=19));;
  Q) ((weekNumber+=20));;
  R) ((weekNumber+=21));;
  S) ((weekNumber+=22));;
  T) ((weekNumber+=23));;
  U) ((weekNumber+=24));;
  V) ((weekNumber+=25));;
  W) ((weekNumber+=26));;
  X) ((weekNumber+=27));;
  Y) ((weekNumber+=28));;
  *)
    echo "Error: Invalid serial number (reason: invalid week number)!"
    exit 128;;
esac

# Get the SSS value (manufacture location) from the serial number
SSS=$(echo $SN | cut -c1-3)

# Generate a random (yet valid) TTT value (board serial)
declare -a TTTCodes=('200' '600' '403' '404' '405' '303' '108' '207' '609' '501' '306' '102' '701' '301' '501' '101' '300' '130' '100' '270' '310' '902' '104' '401' '902' '500' '700' '802')
TTTIndex=$( jot -r 1  0 $((${#TTTCodes[@]} - 1)) )
TTT=${TTTCodes[TTTIndex]}

# Generate a random (yet valid) CC value
declare -a CCCodes=('GU' '4N' 'J9' 'QX' 'OP' 'CD' 'GU')
CCIndex=$( jot -r 1  0 $((${#CCCodes[@]} - 1)) )
CC=${CCCodes[CCIndex]}

# Generate a random (yet valid) EEEE value
declare -a EEEECodes=('G90F' 'G90R' 'G90V')
EEEEIndex=$( jot -r 1  0 $((${#EEEECodes[@]} - 1)) )
EEEE=${EEEECodes[EEEEIndex]}

# Generating a random (yet valid) KK value
declare -a KKCodes=('1H' '1M' 'AD' '1F' 'A8' 'UE' 'JA' 'JC' '8C' 'CB' 'FB')
KKIndex=$( jot -r 1  0 $((${#KKCodes[@]} - 1)) )
KK=${KKCodes[KKIndex]}

MLB=$SSS$manufactureYear$weekNumber$TTT$CC$EEEE$KK

# Other information
biosdate="05/24/15"
biosversion="MBA71.88Z.0166.B00.1502131457"
boardprod="Mac-937CB26E2E02BB01"
prodname="MacBookAir7,2"

# Print the generated information in Apple way
echo ''
echo "Generated serial number: $SN"
case "$SSS" in
  CK2) location="Cork, Ireland";;
  C02) location="Quanta Computer, China";;
esac
echo "Manufacture location (from serial number):" $location
echo "Year of manufacture:" $manufactureYear
echo "Week of manufacture:" $weekNumber
echo "Generated TTT value:" $TTT
echo "Generated CC value:" $CC
echo "Generated EEEE value:" $EEEE
echo "Generated KK value:" $KK
echo "Generated Main Logic Board serial number:" $MLB
echo ''
