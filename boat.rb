require 'socket'

if ARGV.empty?
    puts "Usage - ruby boat.rb host port"
    exit
end

board = "AAAAABBBB." + ("." * 10 * 8) + "CCCDDDEE.."
client = TCPSocket.new ARGV[0], ARGV[1]
puts client.gets
client.puts "J|BoatyMcBoatFace|#{board}"
puts client.gets

board_received = ""
while command = client.gets
    puts command
    if command.start_with? "B|" then board_received = command end
end
