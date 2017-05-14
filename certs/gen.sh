#!/bin/bash

# Create Root CA
cfssl gencert -initca conf/ca-csr.json | cfssljson -bare ca

# Generate user service certs
cfssl gencert \
  -ca=ca.pem \
  -ca-key=ca-key.pem \
  -config=conf/ca-config.json \
  -profile=server \
  conf/user-csr.json | cfssljson -bare user

# Generate task service certs
cfssl gencert \
  -ca=ca.pem \
  -ca-key=ca-key.pem \
  -config=conf/ca-config.json \
  -profile=server \
  conf/task-csr.json | cfssljson -bare task

# Generate jwt signing key pair
cfssl gencert \
  -ca=ca.pem \
  -ca-key=ca-key.pem \
  -config=conf/ca-config.json \
  -profile=signing \
  conf/jwt-csr.json | cfssljson -bare jwt

# Generate client certs
cfssl gencert \
  -ca=ca.pem \
  -ca-key=ca-key.pem \
  -config=conf/ca-config.json \
  -profile=client \
  conf/client-csr.json | cfssljson -bare client