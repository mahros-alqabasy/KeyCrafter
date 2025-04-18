#!/bin/bash


# Password generator tool.
# LENTH, SPECIAL_CHARS:bool, Upper:lower:both
# options: -l(length):integer==8-default, -s(special_chars):special_chars(true):false -c(case):upper(u):lower(l):both(b)


# List of dependencies required by the script.
DEPENDENCIES=( "shuf" "fold" "paste")

check_dependencies() {
  local missing=()
  for dep in "${DEPENDENCIES[@]}"; do
    if ! command -v "$dep" >/dev/null 2>&1; then
      missing+=("$dep")
    fi
  done
  if [ ${#missing[@]} -gt 0 ]; then
    echo "Error: The following dependencies are missing:" >&2
    for dep in "${missing[@]}"; do
      echo "  - $dep" >&2
    done
    echo "Please install them and try again." >&2
    exit 1
  fi
}

# Check for dependencies at the start of the script.
check_dependencies

# Now you can safely assume all required commands are available.
# Example usage of shuf with a fallback for macOS:
if command -v shuf >/dev/null 2>&1; then
  SHUF=shuf
elif command -v gshuf >/dev/null 2>&1; then
  SHUF=gshuf
else
  echo "Error: Neither 'shuf' nor 'gshuf' is installed." >&2
  exit 1
fi



# CODE HERE
# DEFAULTS
LENGTH=8								# Password default length
CASE=both								# Specify Password characters case
HAS_SPECIAL_CHAR=true		# Specify if it should contains special chars
SPECIAL_CHAR_LENGTH=2 		# Specify special char count

# CONSTANTS
ALPHABETS=$(echo {a..z})
SPECIAL_CHARS="!@#$%^&_+='~"


# the total password length must be $LENGTH
# the SPECIAL CHAR LENGTH doesn't affect on $LENGTH


help() {
  cat << 'EOF'
Usage: 
			passwdgen [OPTIONS]
			passwdgen [-l LENGTH] [-L LENGTH] [-S|--no-special] [-c u|l|b]

Password Generator Tool
-----------------------
Generate a random password with configurable length, case options, and special characters.

Options:
  -h, /?           Display this help message and exit.
  -S               Disable special characters in the generated password.
                   (Default: special characters enabled.)
  -l LENGTH        Set the total password length (integer).
                   Default: 8.
  -L LENGTH        Set the number of special characters to append.
                   Must be less than the total password length.
                   Default: 2.
  -c CASE          Specify the case mode for the password:
                     u, upper  - all uppercase letters,
                     l, lower  - all lowercase letters,
                     b, both   - mixed case (default).

Examples:
  passwdgen -l 12 -L 3 -c upper
    Generate a 12-character password with 3 special characters in uppercase.

  passwdgen -S -l 10 -c lower
    Generate a 10-character password with no special characters in lowercase.

Dependencies:
  This tool requires the following utilities:
    • shuf (or gshuf on macOS)
    • fold
    • paste
    • sha256sum
    • cut
    • od
    • tr
    • date

For more information or to report issues, please refer to the documentation.
EOF
}



# This function generated by AI: Please check it.
# Function to generate a random number in a specified range
get_random_number() {
    local min=$1  # Minimum value of range
    local max=$2  # Maximum value of range

    # Validate input
    if [[ -z "$min" || -z "$max" || "$min" -ge "$max" ]]; then
        echo "Error: Invalid range. Usage: random_in_range <min> <max>"
        return 1
    fi

    # Use /dev/urandom to generate a random number
    local range=$((max - min + 1))
    local random_number=$(( ( $(od -An -N4 -tu4 /dev/urandom | tr -d " ") % range ) + min ))

    echo "$random_number"
}



# hash
generate(){
	local PASSWORD=$(date | sha256sum | cut -d" " -f1)
	PASSWORD=${PASSWORD:0:LENGTH}

	# Check if there is special chars
	if [ $HAS_SPECIAL_CHAR = true ]; then
		PASSWORD=${PASSWORD:0:$(($LENGTH - $SPECIAL_CHAR_LENGTH))}

	fi

	# Handle chars cases
	case ${CASE,,} in
		b|both)
			# COUNT OF UPPERS:get random number from 1 to the password length/2
			# THEN select N positions random in the PASSWORD and make them upper
			PASSWORD=${PASSWORD,,}
			UPPERS_COUNT=$((${#PASSWORD} / 2))

			for((i=0; i < $UPPERS_COUNT; i++)); do
				local index=$(get_random_number 0 ${#PASSWORD})
				PASSWORD="${PASSWORD:0:$index}$(echo "${PASSWORD:$index:1}" | tr '[:lower:]' '[:upper:]')${PASSWORD:$index+1}"
			done
			;;
		u|upper)
			PASSWORD=${PASSWORD^^}
			;;
		l|lower)
			PASSWORD=${PASSWORD,,}
			;;
		*)
			echo "Invalid case -$OPTARG, CASES: [u|upper] [l|lower] [b|both]" >&2
			exit 1
			;;
	esac

	# Handle special chars and theirs length
	# check special chars
	if [ $HAS_SPECIAL_CHAR = true ]; then
		local SPECIAL=$(echo "$SPECIAL_CHARS" | fold -w1 | shuf | paste -sd "")
		SPECIAL=${SPECIAL:0:SPECIAL_CHAR_LENGTH}
		PASSWORD+=$SPECIAL
	fi

	# then shuffel all chars in the out
	PASSWORD=$(echo -n "$PASSWORD" | fold -w1 | shuf | paste -sd "")


	# echo password
	echo $PASSWORD
}



# Handle Arguments
while getopts ":hl:L:Sc:" opt; do
	case $opt in
	h|/?)
		help
		exit 1
		;;
	S)
		HAS_SPECIAL_CHAR=false
		;;
	l)
		LENGTH=$OPTARG
		;;
	c)
		CASE=$OPTARG
		;;
	L)
		if [ $OPTARG -ge $LENGTH ]; then
			echo "Special chars LENGTH must be less than PASSWORD length."
			exit 1
		else
			SPECIAL_CHAR_LENGTH=$OPTARG
		fi
		;;
	*)
		echo "Invalid option: -$OPTARG" >&2
		help
		exit 1
		;;
	esac

done


# generate password
generate

exit 0

