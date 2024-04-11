#!/bin/bash

set -e

mkdir -p -m 750 <path to data directory> \
<path to logs directory> \
<path to conf directory> \
<path to backups directory>

chown -R 13001:13001 <path to data directory> \
<path to logs directory> \
<path to conf directory> \
<path to backups directory>