#!/bin/bash

for d in $(find . -name "*.proto"); do
    pushd $d &> /dev/null
    
    protoc -I/usr/local/include -I. \
        -I$GOPATH/src \
        -I${GOPATH}/src/github.com/synoday/synoday/protobuf \
        --go_out=plugins=grpc:$GOPATH/src \
        $d

    popd &> /dev/null
done