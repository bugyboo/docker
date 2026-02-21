docker run -it --name ubuntu-desktop \
    -e DISPLAY=$DISPLAY \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    --device /dev/dri \
    --privileged \
    ubuntu-desktop:22.04