require 'webrick'

# root = File.expand_path '~/public_html'
root = Dir.pwd + '/public_html'
server = WEBrick::HTTPServer.new :Port => 8000, :DocumentRoot => root

trap 'INT' do server.shutdown end
server.start
