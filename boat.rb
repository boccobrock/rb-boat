require 'socket'

abort "Usage - ruby boat.rb host port" if ARGV.empty?

client = TCPSocket.new ARGV[0], ARGV[1]
board = "AAAAABBBB." + ("." * 10 * 8) + "CCCDDDEE.."
shots = Array.new(100) { |x| (x % 10 + 1).to_s + "|" + (x / 10 + 1).to_s }
shots.shuffle!

while message = client.gets
    puts message
    if message[0] == "G" then client.puts "J|McBoatFace|#{board}" end
    if message[0] == "H" then client.puts "M|rando|ouch!" end
    if message.start_with? "N|McBoatFace" then client.puts "S|rando|" + shots.pop end
end
