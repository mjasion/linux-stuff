#!/bin/bash

SITES="http://obibooki.herokuapp.com/ http://astrobotpl.herokuapp.com/"
for site in $SITES; do
    wget -q -O-  $site >> /dev/null
done
