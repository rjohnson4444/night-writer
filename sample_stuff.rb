keys = {
  "a" => ["0.", "..", ".."],
  "b" => ["0.", "0.", ".."],
  "c" => ["00", "..", ".."],
  " " => ["..", "..", ".."]
}

keys.fetch("a").fetch(0)
keys.fetch("a").fetch(1)
keys.fetch("a").fetch(2)


braille = ""
string = "abc \n abc abbbccccaaaa aaaa bbb ccc ccc \n abc"
passes = 0
rows = keys.values_at("a")

string.gsub("\n", "").chars.each do |letter|
  braille_segment = keys.fetch(letter)
  first_row = braille_segment.fetch(0)
  braille << first_row
  braille << "\n\n" if braille.size == 80
  braille
end


puts braille
