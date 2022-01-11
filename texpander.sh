#!/bin/bash

# Version: 2.0
# Release: November 24, 2017

# Get window id, pass to getwindow pid to output the pid of current window
pid=$(xdotool getwindowfocus getwindowpid)

# Store text name of process based on pid of current window
proc_name=$(cat /proc/$pid/comm)

# If ~/.texpander directory does not exist, create it
if [ ! -d ${HOME}/.texpander ]; then
    mkdir ${HOME}/.texpander
fi

# Store base directory path, expand complete path using HOME environemtn variable
base_dir=$(realpath "${HOME}/.texpander")

# Set globstar shell option (turn on) ** for filename matching glob patterns on subdirectories of ~/.texpander
shopt -s globstar

# Find regular files in base_dir, pipe output to sed
# abbrvs=$(find "${base_dir}" -type f | sort | sed "s?^${base_dir}/??g" )

# save launch dir
launch_dir=$(pwd)
# move to base_dir
cd ${base_dir}

# search files and folders in base_dir
choices=$(ls -p --group-directories-first)
# let user select a file or a folder
selection=$(zenity --list --title=Texpander --width=275 --height=400 --column=Abbreviations $choices)

rel_path=""

# while the selection is a folder
while [[ "$selection" == */ ]]
do
  rel_path="$rel_path$selection"
  cd $selection
  # search files and folders in selected dir
  choices=$(ls -p --group-directories-first)
  # let user select a file or a folder
  selection=$(zenity --list --title=Texpander --width=275 --height=400 --column=Abbreviations $choices)
done

# return to launch dir
cd $launch_dir

rel_path="$rel_path$selection"
path="${base_dir}/${rel_path}"

if [ -f "$path" ]
then
  if [ -e "$path" ]
  then
    # Preserve the current value of the clipboard
    clipboard=$(xsel -b -o)

    # Put text in primary buffer for Shift+Insert pasting
    echo -n "$(cat "$path")" | xsel -p -i

    # Put text in clipboard selection for apps like Firefox that 
    # insist on using the clipboard for all pasting
    echo -n "$(cat "$path")" | xsel -b -i

    # Paste text into current active window
    sleep 0.3
    xdotool key shift+Insert

    # If you're having trouble pasting into apps, use xdotool
    # to type into the app instead. This is a little bit slower
    # but may work better with some applications.
    #
    # Make xdotool type RETURN instead of LINEFEED characters 
    # otherwise some apps like Gmail in Firefox won't recognize
    # newline characters.
    #
    # To use this, comment out line #32 (xdotool key shift+Insert)
    # and uncomment the line below.
    #xdotool type -- "$(xsel -bo | tr \\n \\r | sed s/\\r*\$//)"

    # Restore the original value of the clipboard
    sleep 0.5
    echo $clipboard | xsel -b -i

  else
    zenity --error --text="Abbreviation not found:\n${rel_path}"
  fi
fi
