#!/bin/bash

# testing lsof with file descriptors

exec 3>test
exec 6>test
exec 7<test

lsof -a -p $$ -d0,1,2,3,6,7





