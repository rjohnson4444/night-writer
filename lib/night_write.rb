class NightWrite
  attr_reader :message

  def initialize(message=nil)
    @message = message
    @first_row = ""
    @second_row = ""
    @third_row = ""
    @keys = {
          "a" => ["0.", "..", ".."], "A" => ["0.", "..", ".."],
          "b" => ["0.", "0.", ".."], "B" => ["0.", "0.", ".."],
          "c" => ["00", "..", ".."], "C" => ["00", "..", ".."],
          "d" => ["00", ".0", ".."], "D" => ["00", ".0", ".."],
          "e" => ["0.", ".0", ".."], "E" => ["0.", ".0", ".."],
          "f" => ["00", "0.", ".."], "F" => ["00", "0.", ".."],
          "g" => ["00", "00", ".."], "G" => ["00", "00", ".."],
          "h" => ["0.", "00", ".."], "H" => ["0.", "00", ".."],
          "i" => [".0", "0.", ".."], "I" => [".0", "0.", ".."],
          "j" => [".0", "00", ".."], "J" => [".0", "00", ".."],
          "k" => ["0.", "..", "0."], "K" => ["0.", "..", "0."],
          "l" => ["0.", "0.", "0."], "L" => ["0.", "0.", "0."],
          "m" => ["00", "..", "0."], "M" => ["00", "..", "0."],
          "n" => ["00", ".0", "0."], "N" => ["00", ".0", "0."],
          "o" => ["0.", ".0", "0."], "O" => ["0.", ".0", "0."],
          "p" => ["00", "0.", "0."], "P" => ["00", "0.", "0."],
          "q" => ["00", "00", "0."], "Q" => ["00", "00", "0."],
          "r" => ["0.", "00", "0."], "R" => ["0.", "00", "0."],
          "s" => [".0", "0.", "0."], "S" => [".0", "0.", "0."],
          "t" => [".0", "00", "0."], "T" => [".0", "00", "0."],
          "u" => ["0.", "..", "00"], "U" => ["0.", "..", "00"],
          "v" => ["0.", "0.", "00"], "V" => ["0.", "0.", "00"],
          "w" => [".0", "00", ".0"], "W" => [".0", "00", ".0"],
          "x" => ["00", "..", "00"], "X" => ["00", "..", "00"],
          "y" => ["00", ".0", "00"], "Y" => ["00", ".0", "00"],
          "z" => ["0.", ".0", "00"], "Z" => ["0.", ".0", "00"],
          " " => ["..", "..", ".."],
        }
  end

  def print_success_message(message)
    message_counter = message.gsub(" ","").chars.count - 1
    "Created '#{message}' containing #{message_counter} characters."
  end

  def get_text_from_file(file_name)
    text = File.read(file_name)
    text.gsub("\n", "")
  end

  def send_braille_to_file(filename, braille)
    send = File.open(filename, 'w')
    send.write(braille)
  end

  def to_braille
    first_row
    second_row
    third_row
    "#{@first_row}\n#{@second_row}\n#{@third_row}"
  end

  def capital?(letter)
    ("A".."Z").include?(letter)
  end

  def first_row
    @message.gsub("\n", "").chars.each do |letter|
      braille_segment = @keys.fetch(letter)
      first_row = braille_segment.fetch(0)
      first_row.prepend("..") if capital?(letter)
      # @first_row << "\n\n\n" if @first_row.size == 80
      @first_row << first_row
    end
  end

  def second_row
    @message.gsub("\n", "").chars.each do |letter|
      braille_segment = @keys.fetch(letter)
      second_row = braille_segment.fetch(1)
      second_row.prepend("..") if capital?(letter)
      # @second_row << "\n\n\n" if @second_row.size == 80
      @second_row << second_row
    end
  end

  def third_row
    @message.gsub("\n", "").chars.each do |letter|
      braille_segment = @keys.fetch(letter)
      third_row = braille_segment.fetch(2)
      third_row.prepend(".0") if capital?(letter)
      # @third_row << "\n\n\n" if @third_row.size == 80
      @third_row << third_row
    end
  end
end


i_run_my_code_for_real = ($PROGRAM_NAME == __FILE__)
if i_run_my_code_for_real
  ## Convert normal text to Braille
  # Get first file name from command line arguments
  message_file = ARGV[0]

  ## Read from the message.txt file
  message = File.read(message_file)


  ## Create a new braille_output_file and write newly converted Braille
  braille_output_file = ARGV[1]
  braille_output = File.open(braille_output_file, "w")

  ## Print out message that states what file has been created and how many characters are in it.
  message_counter = message.gsub(" ","").chars.count - 1
  puts "Created '#{braille_output_file}' containing #{message_counter} characters."

  ## Convert the normal text to Braille
  braille = NightWrite.new(message).to_braille


  # Write newly converted Braille to output file.
  braille_output.write(braille)
end
