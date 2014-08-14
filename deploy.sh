#!/bin/bash -ex

rsync -avz --progress --exclude '*.iml' ../jenkins-dashboard pi@clienttoolspi:/home/pi
