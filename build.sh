#!/usr/bin/env bash
echo "gonna build...."
haxelib run lime build neko 
rc=$?; if [[ $rc != 0  ]]; then exit $rc; fi

echo "gonna run on neko... "
haxelib run lime run neko
