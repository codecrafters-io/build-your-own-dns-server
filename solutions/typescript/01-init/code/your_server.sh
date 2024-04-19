#!/bin/sh
#
# DON'T EDIT THIS!
#
# CodeCrafters uses this file to test your code. Don't make any changes here!
#
# DON'T EDIT THIS!
# Deno.listenDatagram is still unstable as of Deno 1.42.4
# https://docs.deno.com/runtime/manual/tools/unstable_flags#--unstable-net
exec deno run --allow-net --allow-read --allow-write --unstable-net app/main.ts "$@"
