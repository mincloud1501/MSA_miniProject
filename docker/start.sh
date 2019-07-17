#!/bin/bash

useradd  $USER
echo -e "$PASSWD\n$PASSWD" | (passwd --stdin $USER)
echo  $USER password: $PASSWD
/bin/bash