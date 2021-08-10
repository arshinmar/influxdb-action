
if [ "$INFLUXDB_START" = "true" ]
then
    influxd --config /etc/influxdb/influxdb.conf
fi
