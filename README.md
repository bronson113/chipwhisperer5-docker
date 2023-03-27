# chipwhisperer5-docker

A dockerized chipwhisperer 5 for easy installation. This is a fork of (https://github.com/nezza/chipwhisperer5-docker) with updated runtime and a docker-compose. It runs as user without --privileged.

## Disclaimer

This docker setup will bind to localhost:8888 with no password. I believe this is safe, but this behavior can be changed by commenting out a few lines in `chipwhisperer/startup.sh` and rebuilding the image. It might be to run the image as privileged when an access an access to `/dev/ttyACM0` is needed. Otherwise the device files in `/devacm/` can be used for APIs that allow setting a device file name.

## Install

To install, simply copy and load the newae udev rules and build the docker image:

```
sudo cp chipwhisper/99-newae.rules /etc/udev/rules.d
sudo udevadm control --reload-rules
docker-compose build
```

## Run

```
docker-compose up
```

## Use

The Jupyter Notebook should then be running on port 8888. You can visit it by simply going to

http://127.0.0.1:8888/

The working directory will be initialized in workspace/ and will persist across updates or rebuilds. Labs require heavy modification of this directory, make sure you backup everything you want to keep.

## Full installation example:

```
sudo cp chipwhisper/99-newae.rules /etc/udev/rules.d
sudo udevadm control --reload-rules
docker-compose up -d
```

## Docker-compose problems

Some older versions of docker-compose (such as in Ubuntu 20.04) have troubles with IPv6 addresses and docker-compose version 3. Use the alternate docker-compose script if needed.

```
cp docker-compose2.yml docker-compose.yml
```
