#!/bin/bash
cp versions/CZToken2.sol contracts/CZToken.sol 
zos push --network local
zos update CZToken --network local
