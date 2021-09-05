# Ethereum-Blockchain-for-Healthcare

## Prerequisits

We have used **Ubuntu 18.04.5 (64bit)** in a Virtual Machine (VirtualBox for example) to build this private network.

First, we will have to install Go Implementation of Ethereum, named "Geth". 

To do this, we will add a PPA (Personal Package Archives) to our apt repositories:
```
~$ sudo add-apt-repository -y ppa:ethereum/ethereum
```
Then we can install stable versions of Go Ethereum:
```
~$ sudo apt update
~$ sudo apt install ethereum
```
To verify if it has been done correctly, you can type:
```
~$ geth version
Geth
Version: 1.10.8-stable
Git Commit: 26675454bf93bf904be7a43cce6b3f550115ff90
Architecture: amd64
Go Version: go1.16.4
Operating System: linux
GOPATH=...
GOROOT=...
```
We can now start the setup for the ethereum network.

## Ethereum node
Here, we will see how to setup an ethereum node. note that you have repeat this process for every peer before connecting them in a network.

First, start by creating a working environment:
```
~$ mkdir pnet
~$ cd pnet
pnet$ mkdir node1
```
Then we create an account (wallet). It will contain the user's private and public keys
```
pnet$ geth --datadir node1/ account new
INFO [09-17|10:34:07.533] Maximum peer count                   	ETH=50 LES=0 total=50
INFO [09-17|10:34:07.533] Smartcard socket not found, disabling	err="stat /run/pcscd/pcscd.comm: no such file or directory"
Your new account is locked with a password. Please give a password. Do not forget this password.
Password:
Repeat password:

Your new key was generated

Public address of the key:   0x4B39dA0C0914CFc3525A6CC8B5893d60032F9950
Path of the secret key file: node1/keystore/UTC--2021-09-05T15-47-02.743997096Z--4b39da0c0914cfc3525a6cc8b5893d60032f9950
```
Remember to save the puclic address of the key to a file, as well as the password in a text file, for example:
```
pnet$ echo '4B39dA0C0914CFc3525A6CC8B5893d60032F9950' >> accounts.txt
pnet$ echo '<password>' > node1/password.txt
```
**Create a Genesis file:**

The Genesis file is used to initialize the blockchain with a Genesis Block, based on the parameters contained in the genesis.json file used.

Puppeth helps create the genesis file:

Start puppeth :
```
pnet$ puppeth
```
Then enter a network name :
```
 Please specify a network name to administer (no spaces, hyphens or capital letters please)
> pnet
Sweet, you can set this via --network=pnet next time!
INFO [09-17|11:43:03.307] Administering Ethereum network       	name=pnet
WARN [09-17|11:43:03.367] No previous configurations found     	path=/home/pnet/.puppeth/pnet
```
After that, you will have to make some choices to create the genesis file from scratch. Here are the choices :
```
What would you like to do? (default = stats)
 1. Show network stats
 2. Configure new genesis
 3. Track new remote server
 4. Deploy network components
> 2
What would you like to do? (default = create)
 1. Create new genesis from scratch
 2. Import already existing genesis
> 1
Which consensus engine to use? (default = clique)
 1. Ethash - proof-of-work
 2. Clique - proof-of-authority
> 2
How many seconds should blocks take? (default = 15)
> 3
Which accounts are allowed to seal? (mandatory at least one)
> 0x95491f49d86d68ab43f55db5b6679b4d90f1ea84
> 0x
Which accounts should be pre-funded? (advisable at least one)
> 0x95491f49d86d68ab43f55db5b6679b4d90f1ea84
> 0x
Should the precompile-addresses (0x1 .. 0xff) be pre-funded with 1 wei? (advisable yes)
> yes
Specify your chain/network ID if you want an explicit one (default = random)
> 7410
INFO [09-20|10:07:39.675] Configured new genesis block
```
Then you can export your genesis configuration into a .json file
```
What would you like to do? (default = stats)
 1. Show network stats
 2. Manage existing genesis
 3. Track new remote server
 4. Deploy network components
> 2
 1. Modify existing configurations
 2. Export genesis configurations
 3. Remove genesis configuration
> 2
Which folder to save the genesis specs into? (default = current)
  Will create pnet.json, pnet-aleth.json, pnet-harmony.json, pnet-parity.json
>
INFO [09-20|10:07:58.879] Saved native genesis chain spec      	path=pnet.json
ERROR[09-20|10:07:58.879] Failed to create Aleth chain spec    	err="unsupported consensus engine"
ERROR[09-20|10:07:58.915] Failed to create Parity chain spec   	err="unsupported consensus engine"
INFO [09-20|10:07:58.916] Saved genesis chain spec             	client=harmony path=pnet-harmony.json
What would you like to do? (default = stats)
 1. Show network stats
 2. Manage existing genesis
 3. Track new remote server
 4. Deploy network components
> ^C // Ctrl+c to exit
```

