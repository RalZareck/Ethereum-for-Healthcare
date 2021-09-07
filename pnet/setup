#!/bin/bash

## Creation of the Account

read -p "Name of node to create/manage: " name
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
    printf "$name: $pubKey\n" >> accounts.txt
    printf "Saved at ./accounts.txt\n\n"  

    read -sp "Password: " pass
    printf "$pass\n" > $name/password.txt
    printf "\nSaved at ./$name/password.txt\n"
fi


## Initialisation of the node
printf "\n\n"
read -p "Genesis file (press enter to start the genesis file configuration): " genesis

if [[ -n "$genesis" ]]
then
    geth --datadir $name init $genesis
else
    printf "You can use puppeth to create or manage the genesis file\n"
    printf "(look at the README.md for more information on how to use puppeth)\n\n"
    
    read -p "Do tou want to start puppeth [Y/N]? :" res
    printf "\n"

    if [[ $res == "Y" ]] || [[ $res == "y" ]]
    then
	printf "Ctrl+C to quit puppeth\n"
        puppeth
    else
        exit
    fi
fi

## Creation of the console script

printf "\nCreation of the console command for this node, stored in the 'START_$name' script:\n"
read -p "Console port (default=3010): " cport
if [[ -z $cport ]]
then
	cport=3010
fi

read -p "Networkid (default=7410): " netid
if [[ -z $netid ]]
then
	netid=7410
fi

read -p "RPC port (default=8520): " rpcport
if [[ -z $rpcport ]]
then
	rpcport=8520
fi

read -p "ip address (default=127.0.0.1): " IPaddr
if [[ -z $IPaddr ]]
then
	IPaddr=127.0.0.1
fi

printf "#!/bin/bash\n\ngeth --port $cport --syncmode \"full\" -networkid $netid --datadir=./$name --maxpeers=50  --rpc --rpcport $rpcport --rpcaddr $IPaddr --rpccorsdomain \"*\" --rpcapi \"eth,net,web3,personal,miner\" --allow-insecure-unlock console 2>> eth.log\n" > START_$name

chmod 755 START_$name
