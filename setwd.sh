#!/bin/bash

# =====================================================
# === set working directory in all analysis scripts ===
# =====================================================

# get new working directory
newwd=$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )

# get old working directory from code/01_get_data.sps
oldwd=$(grep cd ${newwd}/code/01_extract_data.sps | sed -e "s+.*cd '++" | sed -e "s+'.*++")

# replace old working directory by new working directory in each script
lsfiles=$(ls ${newwd}/code/*.*)

for file in $lsfiles; do
	cat "${file}" | sed -e "s+${oldwd}+${newwd}+Ig" > ${file}.tmp
	mv "${file}.tmp" "${file}"
	chmod 770 "${file}"
done

echo "old working directory: ${oldwd}"$'\n'\
"new working directory: ${newwd}"$'\n'\
"old replaced by new working directory."