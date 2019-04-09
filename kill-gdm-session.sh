#!/bin/sh

SESSION_ID=$(ps x | grep 'gdm-x-session' | awk '{print $1}')

kill $SESSION_ID
