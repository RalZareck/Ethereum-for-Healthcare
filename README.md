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

The Genesis file is used to initialize the blockchain with a Genesis Block, based on the parameters contained in a genesis.json file.

Puppeth helps create the genesis file:
