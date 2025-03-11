FROM ubuntu:24.04

RUN apt-get update
# Avoid problem with tzdata install...
# Sets timezone to UTC though
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata

# Install dependencies
RUN apt-get install -y python3-pip python3-tk wget git pkg-config libfreetype6-dev libpng-dev libusb-1.0.0 libusb-1.0.0-dev curl
RUN apt-get install -y avr-libc gcc-avr gcc-arm-none-eabi gfortran libopenblas-dev liblapack-dev

# Install node js for jupyter

# Download chipwhisperer
RUN mkdir -p /opt/chipwhisperer
WORKDIR /opt/chipwhisperer
RUN git clone --recursive --depth=1 https://github.com/newaetech/chipwhisperer.git

# Install chipwhisperer
WORKDIR /opt/chipwhisperer/chipwhisperer/

# Dependencies with right version numbers ???
# RUN pip3 install "pandas<1.1" "numpy<1.21" "matplotlib<3.4" "bokeh<3.0"

# RUN tail -n +2 requirements.txt > requirements-new.txt
# RUN sed -i 's/>= 61.0/>= 59.0/' pyproject.toml
# RUN python3 -m pip install -r requirements-new.txt --force-reinstall
# RUN cat pyproject.toml && python3 -m pip install /opt/chipwhisperer/chipwhisperer/

RUN python3 -m pip install -e . --break-system-packages

# Install jupyter and the jupyter dependencies
WORKDIR /opt/chipwhisperer/chipwhisperer/jupyter
RUN python3 -m pip install -r requirements.txt --break-system-packages
RUN python3 -m pip install nbstripout --break-system-packages
RUN nbstripout --install

# Copy udev rules
COPY 99-newae.rules /etc/udev/rules.d/99-newae.rules

COPY startup.sh /
# Create workspace directory (This is where we mount user data)
RUN mkdir -p /cw_workspace
RUN chmod -R 777 /cw_workspace

RUN useradd -m user -G dialout,plugdev
RUN mkdir /devacm
RUN mknod -m a+rw /devacm/ttyACM0 c 166 0
RUN mknod -m a+rw /devacm/ttyACM1 c 166 1
RUN mknod -m a+rw /devacm/ttyACM2 c 166 2
USER user
# Entrypoint is directly the jupyter notebook
CMD /startup.sh
