# Change prompt color depending on environment

# Decide which color based on hostname pattern
  COLOR="\e[0;32m" # Green for test/development
  if  [[ $HOSTNAME == *s ]]; then
      COLOR="\e[0;33m" # Yellow for staging
  fi
  if  [[ $HOSTNAME == *p ]]; then
      COLOR="\e[0;31m" # Red for prod
  fi

# Set propmt variable with name, hostname, path and color
export PS1="${COLOR}\u@\h:\e[m\w $ "
