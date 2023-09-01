#!/bin/bash

SYSTEMDIR=${HOME}/.config/systemd/user
BINDIR=${HOME}/bin/nobvoice

mkdir -p ${SYSTEMDIR}
mkdir -p ${BINDIR}
cp nobvoice.service ${SYSTEMDIR}/
cp -r internal ppn sound ${BINDIR}/
cp nobvoice nobvoice.toml ${BINDIR}/

systemctl --user start nobvoice.service
systemctl --user enable nobvoice.service
