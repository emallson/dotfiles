#!/usr/bin/env bash

for sink in $(pactl list short sinks | grep RUNNING | cut -d$'\t' -f1); do
    ${1//'SINK'/$sink};
done
