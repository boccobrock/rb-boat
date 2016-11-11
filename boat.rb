require 'socket'

abort "Usage - ruby boat.rb host port" if ARGV.empty?

client = TCPSocket.new ARGV[0], ARGV[1]
board = "AAAAA.BBBB" + ("." * 10 * 8) + "CCC.DDD.EE"
shots = Array.new(100) { |x| {:x => x % 10 + 1, :y => x / 10 + 1} }
shots.shuffle!

while message = client.gets
    if message[0] == "G" then client.puts "J|McBoatFace|#{board}" end
    if message[0] == "J" && message != "J|McBoatFace" then enemy = message.strip.sub /J\|/, ''  end
    if message.start_with? "N|McBoatFace" then client.puts "S|#{enemy}|#{shots.first[:x]}|#{shots.shift[:y]}" end
    if message.start_with? "H|McBoatFace" then lasthit = message end
#shots.sort_by! { |a| (3 - a[:x]).abs + (3 - a[:y]).abs }
    if message.start_with? "R|McBoatFace" then puts message end
end
