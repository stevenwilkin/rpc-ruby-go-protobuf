package main

import (
	"errors"
	"log"
	"net"

	"golang.org/x/net/context"
	"google.golang.org/grpc"

	pb "github.com/stevenwilkin/rpc-ruby-go-protobuf/proto"
)

var (
	items         = map[uint32]string{}
	nextId uint32 = 1
)

type itemsServer struct{}

func (s *itemsServer) All(_ context.Context, _ *pb.Empty) (*pb.AllResponse, error) {
	allItems := []*pb.Item{}
	for id, text := range items {
		allItems = append(allItems, &pb.Item{id, text})
	}

	return &pb.AllResponse{Items: allItems}, nil
}

func (s *itemsServer) Create(_ context.Context, req *pb.CreateRequest) (*pb.Empty, error) {
	id := nextId
	items[id] = req.Text
	nextId++

	return &pb.Empty{}, nil
}

func (s *itemsServer) Get(_ context.Context, req *pb.GetRequest) (*pb.Item, error) {
	text, ok := items[req.Id]
	if !ok {
		return &pb.Item{}, errors.New("Not found")
	}

	return &pb.Item{req.Id, text}, nil
}

func (s *itemsServer) Update(_ context.Context, req *pb.UpdateRequest) (*pb.Item, error) {
	_, ok := items[req.Id]
	if !ok {
		return &pb.Item{}, errors.New("Not found")
	}

	items[req.Id] = req.Text

	return &pb.Item{req.Id, items[req.Id]}, nil
}

func (s *itemsServer) Delete(_ context.Context, req *pb.DeleteRequest) (*pb.Empty, error) {
	_, ok := items[req.Id]
	if !ok {
		return &pb.Empty{}, errors.New("Not found")
	}

	delete(items, req.Id)

	return &pb.Empty{}, nil
}

func main() {
	lis, err := net.Listen("tcp", ":7000")
	if err != nil {
		log.Fatalf("failed to listen: %v", err)
	}
	grpcServer := grpc.NewServer()
	pb.RegisterItemsServer(grpcServer, &itemsServer{})
	grpcServer.Serve(lis)
}
