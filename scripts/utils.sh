# used paths for the scripts

declare -A paths

paths[NAME]="DialogueHistory"

paths[ROOT]=$(git rev-parse --show-toplevel)
paths[BACKUP]="${paths[ROOT]}/backup"
paths[CYBERPUNK_ROOT]="/mnt/secondary/SteamLibrary/steamapps/common/Cyberpunk 2077"
paths[CET_PATH]="bin/x64/plugins/cyber_engine_tweaks/mods"
paths[REDSCRIPT_PATH]="r6/scripts"
paths[INPUT_PATH]="r6/input"
paths[ARCHIVE]="/wolvenkit/wolvenkit.zip"

export paths

function file_exists() {
  local file_path="$1"

  if [[ -f "$file_path" ]]; then
    echo 1  # File exists
  else
    echo 0  # File does not exist
  fi
}

function dir_exists() {
  local file_path="$1"

  if [[ -d "$file_path" ]]; then
    echo 1  # File exists
  else
    echo 0  # File does not exist
  fi
}