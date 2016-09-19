def source_code
  File.open(__FILE__, "r") do |file|
    file.readlines.each do |line|
      puts line
    end
  end
end

source_code