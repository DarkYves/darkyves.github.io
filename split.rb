current_word = nil
current_paragraph = []
words = {}
File.readlines('source.txt').each do |line|
  line = line.strip
  if line.length > 0 then
    if current_word != nil then
      current_paragraph.push(line)
    else
      current_word = line
    end
  else
    if current_word then
      words[current_word] = current_paragraph.join("\n")
    end
    current_word = nil
  end
end

words.each do |word, definition|
  page = 100 + rand(100)
  encoding_options = {
    :invalid           => :replace,  # Replace invalid byte sequences
    :undef             => :replace,  # Replace anything not defined in ASCII
    :replace           => '',        # Use a blank for those replacements
    :universal_newline => true       # Always break lines with \n
  }
  filename = word.encode(Encoding.find('ASCII'), encoding_options)
  content = <<-EOS
---
layout: post
title:  #{word.capitalize}
categories: page #{page}
genre: n.m.
---

#{definition}
EOS
  File.open("_posts/2015-01-01-#{filename}.md", "w") do |file|
    file.write(content)
  end
end