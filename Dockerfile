FROM ubuntu:focal
ARG DEBIAN_FRONTEND=noninteractive
ARG UNAME=ef
ARG UID=1000
ARG GID=1000
RUN groupadd -g $GID -o $UNAME
RUN useradd -m -u $UID -g $GID -o -s /bin/bash $UNAME

WORKDIR /home/$UNAME/
RUN apt-get update && \ 
    apt-get -y install fuse &&\
    apt-get -y install libsdl2-dev

RUN usermod -a -G dialout $UNAME
RUN apt-get remove modemmanager -y
RUN apt install gstreamer1.0-plugins-bad gstreamer1.0-libav gstreamer1.0-gl -y    
RUN apt install libqt5gui5 -y

RUN apt install lsof iputils-ping -y

COPY QGroundControl.AppImage .
RUN chmod +x QGroundControl.AppImage

USER $UNAME

CMD /bin/bash

