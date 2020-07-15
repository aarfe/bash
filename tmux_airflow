#!/bin/sh

# TMUX to start local airflow server and scheduler in 2 vertical 
# panes in the same window

# To enable mouse scrolling, create a ~/.tmux.conf and add "set -g mouse on" 

# Variables and titles
SESSIONE_NAME='airflow'
WINDOW_NAME='window_1'
PANE0_NAME='webserver'
PANE1_NAME='scheduler'

# Activate Venv with python dependencies
source ~/Envs/venv_airflow/bin/activate

# Create new session with name
tmux new-session -d -s ${SESSIONE_NAME} -n ${WINDOW_NAME}

# Split the window in 2 panes: 0 and 1
tmux split-window -h -t "${WINDOW_NAME}"
# Set top status bar on for the panes
tmux set -g pane-border-status top

# Manually set panes id to 0 and 1. It could be done automatically
PANE_ID_WEBSERVER=0
PANE_ID_SCHEDULER=1

# Assign names to panes, to see them on the status bar
tmux select-pane -T ${PANE0_NAME} -t ${PANE_ID_WEBSERVER}
tmux select-pane -T ${PANE1_NAME} -t ${PANE_ID_SCHEDULER}

# Send commands to the Panes
tmux send-keys -t ${PANE_ID_WEBSERVER} 'source ~/Envs/venv_airflow/bin/activate' Enter
tmux send-keys -t ${PANE_ID_WEBSERVER} 'airflow webserver' Enter #OK

tmux send-keys -t ${PANE_ID_SCHEDULER} 'source ~/Envs/venv_airflow/bin/activate' Enter
tmux send-keys -t ${PANE_ID_SCHEDULER} 'airflow scheduler' Enter

tmux -2 attach-session -d -t ${SESSIONE_NAME}

# Scrollbar
# ctrl-B + [    --> pgUp pgDown
