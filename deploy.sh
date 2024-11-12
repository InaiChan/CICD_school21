#!/bin/bash

scp -r src/cat/s21_cat borscher@192.168.10.2:/usr/local/bin
scp -r src/grep/s21_grep borscher@192.168.10.2:/usr/local/bin

ssh borscher@192.168.10.2 ls -lah /usr/local/bin/