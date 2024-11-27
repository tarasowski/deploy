#!/usr/bin/env bash
set -ex

TMP_DIR=/tmp/app

rm -r "$TMP_DIR" || true
mkdir "$TMP_DIR"

cp -R * "${TMP_DIR}/"
cp app.service env.ini "${TMP_DIR}/"

rsync -chazP "$TMP_DIR" server1:/tmp/

ssh server1 '
    sudo systemctl stop app || true && \
    sudo cp -R /tmp/app/* /home/_app/ && \
    sudo cp /tmp/app/app.service /etc/systemd/system/ && \
    sudo systemctl daemon-reload && \
    sudo chown -R _app:_app /home/_app/ && \
    sudo chmod 400 /home/_app/env.ini && \
    sudo systemctl start app && \
    sudo systemctl enable app'

rm -r "$TMP_DIR"
