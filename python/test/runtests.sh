#!/bin/bash

for i in *_test.py
do
  echo $i
  ./$i
done
