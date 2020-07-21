#!/bin/sh

# TMUX to start local airflow server and scheduler in 2 vertical 
# panes in the same window

# To enable mouse scrolling, create a ~/.tmux.conf and add "set -g mouse on" 

BROWSER_PATH='/c/Program\ Files\ \(x86\)/Google/Chrome/Application/chrome.exe' 
AIRFLOW_UI='http://localhost:8080'

# Variables and titles
SESSIONE_NAME='airflow'
WINDOW_NAME='window_1'
PANE0_NAME='webserver'
PANE1_NAME='scheduler'
# Manually set panes id to 0 and 1. It could be done automatically
PANE_ID_WEBSERVER=0
PANE_ID_SCHEDULER=1

usage()
{
    echo "usage: airflow_tmux [start | stop]"
}

tmuxstart() {
    # If the session already exists, attach and retun 0
    tmux ls | grep $SESSIONE_NAME && { tmux a -t $SESSIONE_NAME; return 0; }
    
    # Activate Venv with python dependencies
    source ~/Envs/venv_airflow/bin/activate

    # Create new session with name
    tmux new-session -d -s ${SESSIONE_NAME} -n ${WINDOW_NAME}

    # Split the window in 2 panes: 0 and 1
    tmux split-window -h -t "${WINDOW_NAME}"
    # Set top status bar on for the panes
    tmux set -g pane-border-status top

    # Assign names to panes, to see them on the status bar
    tmux select-pane -T ${PANE0_NAME} -t ${PANE_ID_WEBSERVER}
    tmux select-pane -T ${PANE1_NAME} -t ${PANE_ID_SCHEDULER}

    # Send commands to the Panes
    tmux send-keys -t ${PANE_ID_WEBSERVER} 'source ~/Envs/venv_airflow/bin/activate' Enter
    tmux send-keys -t ${PANE_ID_WEBSERVER} 'airflow webserver' Enter #OK

    tmux send-keys -t ${PANE_ID_SCHEDULER} 'source ~/Envs/venv_airflow/bin/activate' Enter
    tmux send-keys -t ${PANE_ID_SCHEDULER} 'airflow scheduler' Enter

    # Start Browser with Airflow UI
    ( sleep 5s; eval $BROWSER_PATH $AIRFLOW_UI ) & 
    # Attach session
    ( tmux -2 attach-session -t ${SESSIONE_NAME} -d )
    
}

tmuxstop() {
    # Stop Airflow processes
    tmux send-keys -t ${PANE_ID_WEBSERVER} 'C-c' Enter
    tmux send-keys -t ${PANE_ID_SCHEDULER} 'C-c' Enter
    # Kill tmux session
    tmux kill-session -t ${SESSIONE_NAME}
}

# MAIN
if [ "$#" -eq 1 ]; then
    ACTION=$1
    case $ACTION in 
        start)
            tmuxstart
            ;;
        stop)
            tmuxstop
            ;;
    esac
else
    usage
fi
