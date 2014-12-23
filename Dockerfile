# set base os
FROM phusion/baseimage:0.9.15
ENV DEBIAN_FRONTEND noninteractive
# Set correct environment variables
ENV HOME /root
# Configure user nobody to match unRAID's settings
RUN \
usermod -u 99 nobody && \
usermod -g 100 nobody && \
usermod -d /home nobody && \
chown -R nobody:users /home
# Install Dependencies and add patchfile
ADD src/5071.patch /5071.patch
RUN apt-get update && \
apt-get install -y python-software-properties software-properties-common && \
add-apt-repository ppa:team-xbmc/unstable && \
add-apt-repository ppa:team-xbmc/xbmc-ppa-build-depends && \
apt-get build-dep -y xbmc && \
apt-get install -y git libxslt-dev && \
# Download XBMC, pick version from github
git clone https://github.com/xbmc/xbmc.git && \
cd xbmc && \
mv /5071.patch /xbmc/5071.patch && \
git checkout 14.0-Helix && \
git apply 5071.patch && \
# Configure, make, clean.
./bootstrap && \
./configure \
--enable-nfs \
--enable-upnp \
--enable-ssh \
--enable-libbluray \
--disable-debug \
--disable-vdpau \
--disable-vaapi \
--disable-crystalhd \
--disable-vdadecoder \
--disable-vtbdecoder \
--disable-openmax \
--disable-joystick \
--disable-rsxs \
--disable-projectm \
--disable-rtmp \
--disable-airplay \
--disable-airtunes \
--disable-dvdcss \
--disable-optical-drive \
--disable-libusb \
--disable-libcec \
--disable-libmp3lame \
--disable-libcap \
--disable-udev \
--disable-libvorbisenc \
--disable-asap-codec \
--disable-afpclient \
--disable-goom \
--disable-fishbmc \
--disable-spectrum \
--disable-waveform \
--disable-avahi \
--disable-non-free \
--disable-texturepacker \
--disable-pulse \
--disable-dbus \
--disable-alsa \
--disable-hal && \
make  && \
make install && \
cd / && \
rm -rf /xbmc
apt-get purge -y --auto-remove git build-essential gcc gawk && \
#apt-get -y autoremove && \
apt-get clean && \
rm -rf /var/lib/apt/lists /usr/share/man /usr/share/doc && \
# Add xmbcfiles
mkdir /xbmcfiles && \
mkdir /advancestore
ADD xbmcdata /xbmcfiles/
ADD src/advancedsettings.xml /advancestore/
# Add firstrun.sh to execute during container startup, changes mysql host settings.
ADD src/firstrun.sh /etc/my_init.d/firstrun.sh
RUN chmod +x /etc/my_init.d/firstrun.sh
# Add xbmc to runit
RUN mkdir /etc/service/xbmc
ADD src/kodi.sh /etc/service/xbmc/run
RUN chmod +x /etc/service/xbmc/run
# set ports
EXPOSE 9777/udp 8080/tcp
