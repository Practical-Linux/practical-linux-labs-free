#!/usr/bin/env bash
set -euo pipefail

STUDENT_HOME="/home/student"
ACH_DIR="$STUDENT_HOME/.achievements"
MISSION_FILE="$STUDENT_HOME/MISSION_COMPLETE"

fail() {
  echo "❌ $1"
  exit 1
}

pass() {
  echo "✔ Lab 000 complete"
  echo
  echo "You didn’t learn commands."
  echo "You learned how to explore."
  echo
  if [ -d "$ACH_DIR" ]; then
    echo "Achievements found:"
    ls -1 "$ACH_DIR" 2>/dev/null || echo "(none yet)"
  fi
  exit 0
}

# Main completion check
[ -f "$MISSION_FILE" ] || fail "Create ~/MISSION_COMPLETE (instructions are inside /lab/assets/notes/welcome.txt)"

pass

