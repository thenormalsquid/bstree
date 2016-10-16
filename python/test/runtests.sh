#!/bin/bash

for i in test_*.py
do
  echo $i
  ./$i
done
