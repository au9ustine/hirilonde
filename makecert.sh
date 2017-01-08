#!/bin/sh

# This generated cert is only for dev only

# Generate seeds for producing cryptographic random numbers
dd if=/dev/urandom of=hirilonde.rnd bs=256 count=1

# Generate certificate and keypair
openssl req \
        -new \
        -x509 \
        -days 3650 \
        -rand hirilonde.rnd \
        -config openssl.cnf \
        -out hirilonde.pem \
        -keyout hirilonde.pem \
        -subj "/C=CN/ST=Shanghai/L=Shanghai/O=au9ustine/OU=DevOps/CN=172.19.0.1"
openssl gendh 2048 >> hirilonde.pem

# Destroy seeds
rm -vf hirilonde.rnd

# Display
echo
echo "Certificate details:"
openssl x509 -subject -dates -fingerprint -noout -in hirilonde.pem
echo
