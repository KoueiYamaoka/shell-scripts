#!/bin/bash

echo $@ | sed -e "s/x/\*/g" | bc  # use x instead of *
