# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: proto/items.proto

require 'google/protobuf'

Google::Protobuf::DescriptorPool.generated_pool.build do
  add_message "itemsproto.Item" do
    optional :id, :uint32, 1
    optional :text, :string, 2
  end
  add_message "itemsproto.AllResponse" do
    repeated :items, :message, 1, "itemsproto.Item"
  end
  add_message "itemsproto.CreateRequest" do
    optional :text, :string, 1
  end
  add_message "itemsproto.GetRequest" do
    optional :id, :uint32, 1
  end
  add_message "itemsproto.UpdateRequest" do
    optional :id, :uint32, 1
    optional :text, :string, 2
  end
  add_message "itemsproto.DeleteRequest" do
    optional :id, :uint32, 1
  end
  add_message "itemsproto.Empty" do
  end
end

module Itemsproto
  Item = Google::Protobuf::DescriptorPool.generated_pool.lookup("itemsproto.Item").msgclass
  AllResponse = Google::Protobuf::DescriptorPool.generated_pool.lookup("itemsproto.AllResponse").msgclass
  CreateRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("itemsproto.CreateRequest").msgclass
  GetRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("itemsproto.GetRequest").msgclass
  UpdateRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("itemsproto.UpdateRequest").msgclass
  DeleteRequest = Google::Protobuf::DescriptorPool.generated_pool.lookup("itemsproto.DeleteRequest").msgclass
  Empty = Google::Protobuf::DescriptorPool.generated_pool.lookup("itemsproto.Empty").msgclass
end