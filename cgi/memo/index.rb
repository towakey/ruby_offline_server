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
    content = {}
    memoJson = {}
    if File.file?(memoFile) then
        memoJson = File.open(memoFile) do |file|
            JSON.load(file)
        end
        content = {"contents" =>cgi['q']}
        # memoJson[SecureRandom.uuid] = content
        memoJson.store(SecureRandom.uuid, content)
        open(memoFile, "w") do |file|
            file.puts(JSON.pretty_generate(memoJson))
        end
    else
        content = {"contents" =>cgi['q']}
        memoJson[SecureRandom.uuid] = content
        open(memoFile, "w") do |file|
            file.puts(JSON.pretty_generate(memoJson))
        end
    end
end


if File.file?(memoFile) then
    memoJson = {}
    memoJson = File.open(memoFile) do |file|
        JSON.load(file)
    end
pu = <<"EOS"
<hr>
EOS
    # puts memoJson
    memoJson.each{|key, value|
        pu = pu + "#{value['contents']}<hr>"
    }
else
pu = <<"EOS"
<hr>
Not found #{memoFile}
EOS
end
puts pu
