#!/bin/bash

awk -F, '{for (i=1; i<=NF; i++) if (i < 11) printf $i ","; print""}' $1
