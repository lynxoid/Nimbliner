#!/bin/bash
set -exou pipefail
# compile w/ docker
IMG=lynxoid/nimbliner_p:0.0.1
echo "Building fresh docker image"
docker build -q -t $IMG -f docker/Dockerfile .

FOFN=genome.fofn
echo "/reference/decoy_and_viral.fa" > $FOFN

# create genome index
time docker run --rm -t -v $HOME/data/reference:/reference/ -v $PWD:/data/ \
                      $IMG \
                      ./bin/indexer -k 20 \
                                    -i /data/$FOFN \
                                    -o /reference/decoy_and_viral_nimbliner.0.0.1
