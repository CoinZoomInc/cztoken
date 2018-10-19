#!/bin/bash
rm build/contracts/*
rm zos.local.json
cp versions/CZToken1.sol contracts/CZToken.sol 
zos add CZToken
zos push --network local
zos create CZToken --init initialize --args COINZOOM,ZOOM,18,42 --network local
