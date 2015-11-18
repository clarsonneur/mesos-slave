#!/bin/sh

PRINCIPAL=${PRINCIPAL:-root}

echo "$0 Running systemd"

if [ -n "$SECRET" ]; then
    touch /tmp/credential
    chmod 600 /tmp/credential
    echo -n "$PRINCIPAL $SECRET" > /tmp/credential
    export MESOS_CREDENTIAL=/tmp/credential
fi

env | grep MESOS | while read LINE
do
  echo "Setting $LINE"

  echo "$LINE" >> /etc/default/mesos-slave
done

exec "$@"
