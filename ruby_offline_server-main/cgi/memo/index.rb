require "cgi"
require 'json'
require 'securerandom'

print "Content-type: text/html\n\n"

cgi = CGI.new

puts <<'EOS'
<form action="/cgi/memo/index.rb">
    <textarea name="memo"></textarea>
    <input type="hidden" name="cmd" value="add">
    <button>Send</button>
</form>
EOS

memoFile = 'memo.json'

case cgi['cmd']
when 'add' then
    # クエリがあった場合の処理
    if cgi['memo']!='' then
        content = {}
        memoJson = {}
        if File.file?(memoFile) then
            memoJson = File.open(memoFile) do |file|
                JSON.load(file)
            end
            content = {"contents" =>cgi['memo']}
            # memoJson[SecureRandom.uuid] = content
            memoJson.store(SecureRandom.uuid, content)
            open(memoFile, "w") do |file|
                file.puts(JSON.pretty_generate(memoJson))
            end
        else
            content = {"contents" =>cgi['memo']}
            memoJson[SecureRandom.uuid] = content
            open(memoFile, "w") do |file|
                file.puts(JSON.pretty_generate(memoJson))
            end
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
        pu = pu + "<p>#{value['contents'].gsub(/\n/, '<br>')}</p><hr>"
    }
else
pu = <<"EOS"
<hr>
Not found #{memoFile}
EOS
end
puts pu
