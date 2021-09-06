#!/bin/bash

## Creation of the Account

read -p "Name of node to create: " name
mkdir $name
geth --datadir $name account new

echo "Remember to save you account public address key and password to a file\n"

## Creation and/or management of the genesis file

read -p "Do you want to create or manage a genesis file [Y/N] ?" answer
if [[ "$answer" == "Y" ]] || [[ "$answer" == "y" ]]
then
    puppeth
fi

## Initialisation of the node

read -p "Genesis file: " genesis
geth --datadir $name init $genesis
