#!/bin/bash

if [ -d "/root/.kodi/userdata" ]; then
echo "using existing datafiles"
else
echo "creating datafiles"
cp -pr /xbmcfiles/* /root/.kodi
sleep 45
fi
if [ -f "/root/.kodi/userdata/advancedsettings.xml" ]; then
echo "using existing advancedsettings.xml"
sed -i "s|\(<host>\)[^<>]*\(</host>\)|\1${MYSQLip}\2|" /root/.kodi/userdata/advancedsettings.xml
sed -i "s|\(<port>\)[^<>]*\(</port>\)|\1${MYSQLport}\2|" /root/.kodi/userdata/advancedsettings.xml
sed -i "s|\(<user>\)[^<>]*\(</user>\)|\1${MYSQLuser}\2|" /root/.kodi/userdata/advancedsettings.xml
sed -i "s|\(<pass>\)[^<>]*\(</pass>\)|\1${MYSQLpass}\2|" /root/.kodi/userdata/advancedsettings.xml
else
cp /advancestore/advancedsettings.xml /root/.kodi/userdata/advancedsettings.xml
sed -i "s|\(<host>\)[^<>]*\(</host>\)|\1${MYSQLip}\2|" /root/.kodi/userdata/advancedsettings.xml
sed -i "s|\(<port>\)[^<>]*\(</port>\)|\1${MYSQLport}\2|" /root/.kodi/userdata/advancedsettings.xml
sed -i "s|\(<user>\)[^<>]*\(</user>\)|\1${MYSQLuser}\2|" /root/.kodi/userdata/advancedsettings.xml
sed -i "s|\(<pass>\)[^<>]*\(</pass>\)|\1${MYSQLpass}\2|" /root/.kodi/userdata/advancedsettings.xml
fi
