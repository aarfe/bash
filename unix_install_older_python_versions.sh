# Install different version of python in Ubuntu 20.04
# This could be useful to create some older version python virtual environmnts 

sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt-get update
sudo apt-get install python3.6
sudo apt-get install python3.6-venv

# Install you specific python version venv
python3.6 -m venv ./airflow
