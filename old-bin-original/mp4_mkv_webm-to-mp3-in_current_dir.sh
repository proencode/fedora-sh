#!/usr/bin/env bash

# My bash Script to convert mp4 to mp3
# By NerdJK23
# web: www.computingforgeeks.com
# email: kiplangatmtai@gmail.com

# Requires
# ffmpeg installed
# lame installed
# Check https://computingforgeeks.com/how-to-convert-mp4-to-mp3-on-linux/

echo -ne """
1: Current directory 현재의 디렉토리에서 처리
2: Provide directory 디렉토리를 지정함
"""
echo ""
echo -n "Selection : "
read selection

case $selection in
    1)
	echo "Okay.."
	echo ""
	echo "Current dir is `pwd` "
	;;
    2)
    echo ""
    echo -n "Give diretory name: "
    read dir_name

# Check if given directory is valid
if [ -d $dir_name ]; then
    
    cd "${$dir_name}"
    echo "Current directory is `pwd` "
    echo 
else
    echo "Invalid directory, exiting.."
    echo ""
    exit 10
fi

    echo
    ;;
    
   *)
       echo
       echo "Wrong selection"
       exit 11
       ;;
esac

echo ""

# Create dir to store mp3 files if it doesn't exist
# First get the current directory name

current_dir=`pwd`
base_name=` basename "$current_dir"`

if [[ ! -d "$base_name"_to_mp3 ]]; then
    
echo "$base_name" | xargs  -d "\n" -I {} mkdir {}_to_mp3
    echo ""
fi
echo ""


# Bigin to covert videos to mp3 audio files
# -d "\n" > Change delimiter from any whitespace to end of line character 

new_mp3_dir="${base_name}"_to_mp3

find . -name "*.mp4" -o -name "*.mkv" -o -name "*.webm" | xargs  -d "\n"  -I {} ffmpeg -i {} -b:a 320K -vn "$new_mp3_dir"/{}.mp3 

# remove video extensions

cd "${new_mp3_dir}"

for file_name in *; do      
    mv "$file_name" "`echo $file_name | sed  "s/.mp4//g;s/.mkv//g;s/.webm//g"`";
done

# Move audio directory to ~/음악

if [[ ! -d ~/음악 ]]; then
    mkdir ~/음악
fi
cd ..

mv  "$new_mp3_dir" ~/음악/

# Check if conversion successfull

echo ""

if [[ $? -eq "0" ]];then
    echo " All files converted successfully"
else
    echo "Conversation failed"
    exit 1
fi

