require "option_parser"
require "http/server"

module HTTP::Sink
  VERSION = "0.1.0"
end

config = {} of Symbol => String

OptionParser.parse do |parser|
  parser.banner = "HTTP Sink ready to blackhole some requests!"
  
  parser.on "-p PORT", "--port PORT", "Port to listen on" do |port|
    config[:port] = port
  end
end

server = HTTP::Server.new do |context|
  context.response.content_type = "text/plain"
  context.response.print "OK\n"
end

address = server.bind_tcp((config[:port] || "8080").to_i)
puts "Listening on http://#{address}"
server.listen
