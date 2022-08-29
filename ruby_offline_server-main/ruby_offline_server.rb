require 'webrick'
require 'dotenv'

include WEBrick
module WEBrick::HTTPServlet
    FileHandler.add_handler('rb', CGIHandler)
end

Dotenv.load

puts ENV["RUN_FILE"]

# root = File.expand_path '~/public_html'
root = Dir.pwd + '/public_html'
opts = {
    :Port => 8000,
    :DocumentRoot => root,
    :CGIInterpreter => ENV["RUN_FILE"]
}
server = WEBrick::HTTPServer.new(opts)
# server = WEBrick::HTTPServer.new :Port => 8000, :DocumentRoot => root

# server.mount('/cgi', WEBrick::HTTPServlet::CGIHandler, 'cgi.rb')
server.mount('/cgi', WEBrick::HTTPServlet::FileHandler, Dir.pwd+'/cgi', {:FancyIndexing => true})

trap 'INT' do server.shutdown end
server.start
