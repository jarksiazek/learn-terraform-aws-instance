#! /bin/bash
echo "hello bash script"
echo "hello bash script" > file.txt
# cat > file.txt - creating new file
: 'cat >> file.txt - adding text to existing file new file'

cat << creative
Test it
creative

#condition 1
count=10
if [ $count -eq 10 ]
then
  echo "condition is true"
fi

#condition 2
count=9
if [ $count -eq 10 ]
then
  echo "condition is true"
else
  echo "is the different number"
fi

#switch
car=$1
case $car in
  "BMW" )
    echo "BMW";;
    * )
    echo "Unknown";;
esac

#while
echo "while"
number=1
while [ $number -lt 10 ]
do
  echo "$number"
  number=$(( number+1 ))
done

#for 1
echo "for 1"
for i in {1..5} ; do
    echo $i

done

#for 2
echo "for 2"
for (( i=0; i<5; i++)) ; do
    echo $i
done

#read input
#args=("$@") #unlimited array input
#echo $@ #print all inputted data
#echo $# #print length of inputted data

#read file
: 'while read line
do
  echo "$line"
done < "${1:-/dev/stdin}" #file name with predefined path
'

#write file standard output
ls -al 1>file1.txt 2>file2.txt

#write file use one file for standard output and error approach 1
ls -al 1>file1.txt 2>&1

#write file use one file for standard output and error approach 2
ls -al >& file1.txt

#-------------------------------------------------------------------
#sending one script to another script
MESSAGE="Hello from script1"
export MESSAGE
./anotherScript.sh

#-------------------------STRINGS-----------------------------------
#concatenate
str1="abc"
str2="acb"

c=$str1$str2
echo $c

#upper and lower cases
str1="abc"

#first letter is upper
echo ${str1^}
#first text is upper
echo ${str1^^}
#first text is upper
echo ${str1^a}

#-------------------------NUMBERS----------------------------------
n1=2
n2=20
echo $((n1+n2))
echo $((n1-n2))
echo $((n1*n2))
echo $((n1/n2))
echo $((n1%n2))

echo $(expr $n1 + $n2 )
echo $(expr $n1 - $n2 )
echo $(expr $n1 \* $n2 )
echo $(expr $n1 / $n2 )
echo $(expr $n1 % $n2 )

hex=FFFF
echo $hex
#echo "obase=10; ibase=16; $hex" | bc

#-------------------------ARRAYS----------------------------------
cars=('BMW' 'TOYOTA')
echo ${cars[@]} #print all values
echo ${!cars[@]} #print all indexes
echo ${#cars[@]} #length of array
unset cars[1] #delete element at index 1
cars[1]="Toyota" #set element at index 1

#-------------------------FUNCTIONS--------------------------------
function funcName() {
    echo "This is new functions"
}

function funcPrintValue() {
    echo $1
}

function funcReturn() {
    func_result=$1
}

funcName
funcPrintValue "Print this value"
funcReturn "Returning Value"
echo $func_result

#-------------------------FILES--------------------------------
mkdir -p test #make directory -p do not create when exists

directory="NewFolder"
if [ -d "$directory" ]; then
  echo $directory
fi #check if folder exists

file="file.txt"
touch "test/"$file
if [ -f "$file" ]; then
  echo $file
fi #check if folder exists

#reading text from file
if [ -f "$file" ]
then
  while IFS= read -r line
  do
    echo $line
  done < $file
fi #check if folder exists

#-------------------------SENDING EMAIL------------------------
#first install ssmpt

#-------------------------CURL---------------------------------
url=http://www.ovh.net/files/1Mb.dat
#curl {$url} -o newFile # download and rename

#curl -I {$url} # get headers

#-------------------------GREP---------------------------------
fileName="./test/file.txt"
grep -i linux $fileName #grep linux from file
# -i ignore case sensitivity
# -n to get number of line
# -c times appeared on the text
# -v show lines without searching word

#-------------------------AWK----------------------------------
awk '/linux/ {print}' $fileName #print linux text from file
awk '/linux/ {print $2}' $fileName #print only second word where line contains linux word

#-------------------------SED - stream editor------------------
cat $fileName | sed 's/i/I/' #search text and change first i from every line to I
cat $fileName | sed 's/i/I/g' #search text and change every i to I

#-------------------------Debug--------------------------------
# bash -x .helloScript.sh