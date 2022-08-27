require "cgi"
require 'json'
require 'securerandom'

print "Content-type: text/html\n\n"

cgi = CGI.new

puts <<'EOS'
<form action="/cgi/memo/index.rb">
    <input name="q">
    <button>Send</button>
</form>
EOS

memoFile = 'memo.json'

# ƒNƒGƒŠ‚ª‚ ‚Á‚½ê‡‚Ìˆ—
if cgi['q']!='' then
    if File.file?(memoFile) then
        memoJson = File.open(memoFile) do |file|
            JSON.load(memoJson)
        end
    end
    memoJson[SecureRandom.uuid]['contents'] = cgi['q']
    open(memoFile, "a") do |file|
        file.puts(JSON.pretty_generate(memoJson))
    end
end


if File.file?(memoFile) then
else
pu = <<"EOS"
<hr>
Not found #{memoFile}
EOS
puts pu
end
