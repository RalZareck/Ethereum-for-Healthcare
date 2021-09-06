#!/bin/bash

## Creation of the Account

read -p "Name of node to create: " name
present=`ls`

if [[ -z $name ]]
then
    printf "You have to give a name\n"
    exit
elif [[ ! $present =~ $name ]]
then

    mkdir $name
    geth --datadir $name account new

    printf "Remember to save you account public address key and password to a file\n"
    read -p "Account public key: " pubKey
    read -sp "Password: " pass

    printf "$name: $pubKey\n" >> accounts.txt
    printf "$pass\n" > $name/password.txt
fi


## Initialisation of the node
printf "\n\n"
read -p "Genesis file (enter if you want to pass initialisation step): " genesis

if [[ -n "$genesis" ]]
then
    geth --datadir $name init $genesis
else
    printf "You can use puppeth to create or manage the genesis file\n"
    printf "(look at the README.md for more information on how to use puppeth)\n\n"
    
    read -p "Do tou want to start puppeth [Y/N]? :" res
    printf "\n"

    if [[ "$res" == "Y" ]] || [[ "$res" == "y" ]]
    then
	printf "Ctrl+C to quit puppeth\n"
        puppeth
    fi
fi

## Creation of the console script

printf "Creation of the console command, stored in the 'console.sh' script:\n"
read -p "Console port: " cport
read -p "Networkid: " netid
read -p "RPC port: " rpcport
read -p "ip address: " IPaddr

printf "#!/bin/bash\n\ngeth --port $cport --syncmode \"full\" -networkid $netid --datadir=./$name --maxpeers=50  --rpc --rpcport $rpcport --rpcaddr $IPaddr --rpccorsdomain \"*\" --rpcapi \"eth,net,web3,personal,miner\" --allow-insecure-unlock console 2 >> eth.log\n" > START_$name

chmod 755 START_$name
