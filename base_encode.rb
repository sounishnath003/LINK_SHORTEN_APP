require 'base64'
p Base64.encode64 'I am a Ruby Developer' [0..1]

s = 'sounish'
p s.each_byte.map {|xx| xx.to_s(16)}.join

p s.scan(/../).map { |cc| cc.hex.chr}.join