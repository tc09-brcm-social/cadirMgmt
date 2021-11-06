#!/bin/bash
VER=$(curl --version | grep curl | awk '{print $2;}')
echo $VER
