#! /bin/sh

SELF_NAME="build.sh"
VERSION="1.0.0"
FILE_NAME="go-example"
BUILD_NAME="output"
CURR_DIR=`pwd`

echo "start build go env ..."
if [ ! -d "$CURR_DIR/env/go" ]; then 
  tar  -zxvf $CURR_DIR/env/go1.3.3.src.tar.gz  -C  $CURR_DIR/env/
  cd $CURR_DIR/env/go/src/ && ./all.bash
fi

echo "Set Go Env ..."
export GOROOT=$CURR_DIR/env/go
export PATH=$GOROOT/bin:$CURR_DIR/bin/:$PATH

if [[ $GOPATH != *$CURR_DIR* ]]; then
    export GOPATH=$GOPATH:$CURR_DIR
fi
export GOPATH=$CURR_DIR
echo "$GOPATH"
echo "$GOROOT"
echo "$PATH"

echo "build proj ..."
cd $CURR_DIR/src/
go install go-example

rm -rf $CURR_DIR/$BUILD_NAME

mkdir -p $CURR_DIR/$BUILD_NAME/bin
mkdir -p $CURR_DIR/$BUILD_NAME/conf

cp $CURR_DIR/bin/$FILE_NAME $CURR_DIR/$BUILD_NAME/bin/

echo "build succeed!"
exit 0
