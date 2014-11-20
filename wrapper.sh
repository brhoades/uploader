#!/bin/bash
cd $1
ruby capture.rb --help
echo ""
echo ""
echo "Enter arguments for the converter script in:"

read args

echo "ruby capture.rb $args"
ruby capture.rb $args
wait
