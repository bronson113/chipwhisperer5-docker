#!/bin/sh
if [ -d "/cw_workspace/chipwhisperer" ];
then
	echo "CW directory already set up"
else
	echo "Initializing workspace, it will take a while..."
	cp -a /opt/chipwhisperer/chipwhisperer/ /cw_workspace/
fi

cd /cw_workspace/chipwhisperer/jupyter

if [ ! -f "/home/user/.jupyter/jupyter_notebook_config.py" ]
then
	jupyter notebook --generate-config
	# Remove these two lines if you want to enable token or password authentication
	echo "c.NotebookApp.token = ''" >> /home/user/.jupyter/jupyter_notebook_config.py
	echo "c.NotebookApp.password = ''" >> /home/user/.jupyter/jupyter_notebook_config.py
	# signing labs makes things like progress bar easier
	jupyter trust */*/*/*.ipynb */*/*.ipynb */*.ipynb *.ipynb
fi

#ln -sf /dev_host/ttyACM0 /dev/ttyACM0
#ln -sf /dev_host/ttyACM1 /dev/ttyACM1

echo "\e[32mConnect now to:\e[0m \e[1m\e[4mhttp://localhost:8888/\e[0m"
jupyter notebook --ip=0.0.0.0 --port=8888 --no-browser /cw_workspace/chipwhisperer/jupyter/ ${JUPYTER_OPT}
