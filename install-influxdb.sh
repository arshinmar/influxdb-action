cd /tmp
if [ "$INFLUXDB_VERSION" = "latest" ];
then
  export INFLUXDB_VERSION=$(curl --silent "https://api.github.com/repos/influxdata/influxdb/releases" | jq -r '. | sort_by(.tag_name) | reverse[] | .tag_name' | sed -e 's/v//g' | head -n 1)
  export INFLUXDB_DOWNLOAD_PATH="https://dl.influxdata.com/influxdb/releases"
elif [ "$INFLUXDB_VERSION" = "nightly" ];
then
  export INFLUXDB_DOWNLOAD_PATH="https://dl.influxdata.com/platform/nightlies"
else
  export INFLUXDB_DOWNLOAD_PATH="https://dl.influxdata.com/influxdb/releases"
fi
wget -q $INFLUXDB_DOWNLOAD_PATH/influxdb-$INFLUXDB_VERSION-static_linux_amd64.tar.gz
echo '1'
tar xvfz influxdb-$INFLUXDB_VERSION-static_linux_amd64.tar.gz
echo '2'
sudo cp influxdb-$INFLUXDB_VERSION-1/influxd /usr/local/bin/
echo '3'
rm -r influxdb-$INFLUXDB_VERSION-1/
echo '4'
cd -
echo '5'
