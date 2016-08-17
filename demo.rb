#!/usr/bin/env ruby

$: << '.'

require 'bundler/setup'
require 'proto/items_services'

$stub = Itemsproto::Items::Stub.new('localhost:7000', :this_channel_is_insecure)

def print_item(item)
  puts "#{item.id} - #{item.text}"
end

def list_items
  puts
  puts '> List items:'
  sorted = $stub.all(Itemsproto::Empty.new).items.sort_by { |item| item.id }
  sorted.each do |item|
    print_item(item)
  end
end

puts '> Create items:'
%w{first second third forth}.each do |text|
  puts text
  $stub.create(Itemsproto::CreateRequest.new(text: text))
end

list_items

puts
puts '> Retrieve item 2:'
print_item($stub.get(Itemsproto::GetRequest.new(id: 2)))

puts
puts '> Delete item 3:'
$stub.delete(Itemsproto::DeleteRequest.new(id: 3))
puts "Deleted"

puts
puts '> Delete item 3 again:'
begin
  $stub.delete(Itemsproto::DeleteRequest.new(id: 3))
rescue
  puts "Not deleted"
end

list_items

puts
puts '> Update item 2:'
$stub.update(Itemsproto::UpdateRequest.new(id: 2, text: 'very second'))
puts "Updated"

list_items
