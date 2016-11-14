require 'socket'

abort "Usage - ruby boat.rb host port" if ARGV.empty?
client = TCPSocket.new ARGV[0], ARGV[1]
shots = Array.new(100) { |x| {:x => x % 10 + 1, :y => x / 10 + 1} }.shuffle

while message = client.gets
    if message[0] == "G" then client.puts "J|McBoatFace|AAAAA.BBBB#{"." * 10 * 8}CCC.DDD.EE" end
    if message[0] == "J" && message != "J|McBoatFace" then enemy = message.strip.sub /J\|/, ''  end
    if message.start_with? "N|McBoatFace" then client.puts "S|#{enemy}|#{shots.first[:x]}|#{shots.shift[:y]}" end
    if message.start_with? "H|McBoatFace" then
        x = (message.split('|')[3][0].ord - 96).to_i
        y = (message.split('|')[3][1..2]).to_i
        shots.sort_by! { |a| (x - a[:x]).abs + (y - a[:y]).abs < 2 ? 1 : 10 }
    end
    if message.start_with? "R|McBoatFace" then puts message end
end
