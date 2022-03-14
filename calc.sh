#!/bin/bash

echo $@ | sed -e "s/x/\*/g" | bc -l  # use x instead of *
