#! /bin/sh

eval "$4"

[ "$state" = "floating" ] && echo "desktop=focused"
