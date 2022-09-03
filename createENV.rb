paths = ENV['PATH'].split(File::PATH_SEPARATOR)

ruby_path = ""
paths.each do |path|
    exe = File.join(path, "ruby.exe")
    if File.executable?(exe) then
        ruby_path = exe.gsub(/\\/, '/')
    end
end
# puts ruby_path

open(".env", "w") do |file|
    file.puts('RUN_FILE="'+ruby_path+'"')
end
