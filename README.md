# rpc-ruby-go-protobuf

A fork of [soa-ruby-go](https://github.com/stevenwilkin/soa-ruby-go) to
demonstrate defining an RPC service in Go and accessing it from Ruby.

## Starting the API 

Ensure [Go](http://golang.org/) is installed and your ``$GOPATH`` is set, then run the following:

	go get github.com/{stevenwilkin/rpc-ruby-go-protobuf,tools/godep}
	cd $GOPATH/src/github.com/stevenwilkin/rpc-ruby-go-protobuf
	godep restore
	go run ./api.go

## Run the demo script

Ensure [Bundler](http://bundler.io/) and an appropriate Ruby interpreter are available and run:

	bundle install
	./demo.rb 2>/dev/null

The service stores items in-memory and the demo script adds and then manipulates some data. Output should be like the following:

	$ ./demo.rb 2>/dev/null
	> Create items:
	first
	second
	third
	forth
	
	> List items:
	1 - first
	2 - second
	3 - third
	4 - forth
	
	> Retrieve item 2:
	2 - second
	
	> Delete item 3:
	Deleted
	
	> Delete item 3 again:
	Not deleted
	
	> List items:
	1 - first
	2 - second
	4 - forth
	
	> Update item 2:
	Updated
	
	> List items:
	1 - first
	2 - very second
	4 - forth

## Updating the generated code

The protocol buffer compiler is required. On OS X it is installed via:

	brew install --devel protobuf

Assuming the Go and Ruby dependencies have been previously installed the
generated code is produced thus:

	protoc --go_out=plugins=grpc:. proto/items.proto
	protoc --grpc_out=. --ruby_out=. --plugin=protoc-gen-grpc=`which grpc_tools_ruby_protoc_plugin.rb` proto/items.proto
