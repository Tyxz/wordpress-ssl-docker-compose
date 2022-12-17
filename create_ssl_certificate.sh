#!/bin/bash
execute_generation_if_not_exist()
{
    FILE=$1
    COMMAND=$2
    if [ ! -f $FILE ]; 
        then
            echo "$COMMAND -out $FILE"
            $COMMAND -out $FILE
        else
            echo "$FILE already exists"
    fi
}

# Create root auhtority private key
execute_generation_if_not_exist "./config/root/private/root.rsa.key" "openssl genrsa"
# Create root authority certificate
execute_generation_if_not_exist "./config/root/certs/root.x509.crt" "openssl req -x509 -new -nodes -sha256 -days 365 \
                                                                    -key ./config/root/private/root.rsa.key \
                                                                    -config ./config/root/request.config"
# Create website private key
execute_generation_if_not_exist "./config/ssl/private/docker.rsa.key" "openssl genrsa"
# Create websize certificate
execute_generation_if_not_exist "./config/ssl/certs/docker.x509.crt" "openssl req -nodes \
                                                                        -config ./config/ssl/request.config \
                                                                        -key ./config/ssl/private/docker.rsa.key \
                                                                        -CA ./config/root/certs/root.x509.crt \
                                                                        -CAkey ./config/root/private/root.rsa.key"