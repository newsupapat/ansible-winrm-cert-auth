#/bin/bash

# generate the certs
openssl req -x509 -nodes -days 36500 -newkey rsa:2048 -out client_cert_admin.pem -outform PEM -keyout client_key_admin.pem -subj "/CN=Administrator" -extensions v3_req_client
