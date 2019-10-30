# Change prompt color depending on environment

# Decide which color

# Default to GREEN for test/development
COLOR="\[\e[0;32m\]" 

# other environemnts
if  [[ $HOSTNAME == *s ]]; then
    COLOR="\[\e[0;33m\]" # YELLOW for staging
fi
if  [[ $HOSTNAME == *p ]]; then
    COLOR="\[\e[0;31m\]" # RED for prod
fi

# Parse git branch 
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# Set propmt variable with name, hostname, path and color
export PS1="${COLOR}\u@\h:\[\e[m\]\w $(parse_git_branch)\[\033[00m\] "
