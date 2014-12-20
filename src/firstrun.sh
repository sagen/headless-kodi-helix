#!/bin/bash

if [ -d "/opt/kodi-server/share/kodi/portable_data/userdata" ]; then
echo "using existing datafiles"
else
echo "creating datafiles"
cp -pr /xbmcfiles/* /opt/kodi-server/share/kodi/portable_data
sleep 30
fi
if [ -f "/opt/kodi-server/share/kodi/portable_data/userdata/advancedsettings.xml" ]; then
echo "using existing advancedsettings.xml"
sed -i "s|\(<host>\)[^<>]*\(</host>\)|\1${MYSQLip}\2|" /opt/kodi-server/share/kodi/portable_data/userdata/advancedsettings.xml
sed -i "s|\(<port>\)[^<>]*\(</port>\)|\1${MYSQLport}\2|" /opt/kodi-server/share/kodi/portable_data/userdata/advancedsettings.xml
sed -i "s|\(<user>\)[^<>]*\(</user>\)|\1${MYSQLuser}\2|" /opt/kodi-server/share/kodi/portable_data/userdata/advancedsettings.xml
sed -i "s|\(<pass>\)[^<>]*\(</pass>\)|\1${MYSQLpass}\2|" /opt/kodi-server/share/kodi/portable_data/userdata/advancedsettings.xml
else
cp /advancestore/advancedsettings.xml /opt/kodi-server/share/kodi/portable_data/userdata/advancedsettings.xml
sed -i "s|\(<host>\)[^<>]*\(</host>\)|\1${MYSQLip}\2|" /opt/kodi-server/share/kodi/portable_data/userdata/advancedsettings.xml
sed -i "s|\(<port>\)[^<>]*\(</port>\)|\1${MYSQLport}\2|" /opt/kodi-server/share/kodi/portable_data/userdata/advancedsettings.xml
sed -i "s|\(<user>\)[^<>]*\(</user>\)|\1${MYSQLuser}\2|" /opt/kodi-server/share/kodi/portable_data/userdata/advancedsettings.xml
sed -i "s|\(<pass>\)[^<>]*\(</pass>\)|\1${MYSQLpass}\2|" /opt/kodi-server/share/kodi/portable_data/userdata/advancedsettings.xml
fi
