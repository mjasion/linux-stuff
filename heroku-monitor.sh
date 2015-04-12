#!/bin/bash

SITES="http://obibooki.herokuapp.com/ http://astrobotpl.herokuapp.com/ http://movies-rss.herokuapp.com/admin/statistics"
for site in $SITES; do
    wget -q -O-  $site >> /dev/null
done
