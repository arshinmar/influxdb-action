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
tar xvfz influxdb-$INFLUXDB_VERSION-static_linux_amd64.tar.gz
sudo cp influxdb-$INFLUXDB_VERSION-static_linux_amd64/influxd /usr/local/bin/
rm -r influxdb-$INFLUXDB_VERSION-static_linux_amd64/

wget -q $INFLUXDB_DOWNLOAD_PATH/influxdb-client-$INFLUXDB_VERSION-static_linux_amd64.tar.gz
tar xvfz influxdb-client-$INFLUXDB_VERSION-static_linux_amd64.tar.gz
sudo cp influxdb-client-$INFLUXDB_VERSION-static_linux_amd64/influx /usr/local/bin/
rm -r influxdb-client-$INFLUXDB_VERSION-static_linux_amd64/

cd -
