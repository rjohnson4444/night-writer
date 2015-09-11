class NightRead

  def self.convert_to_text(message)

  end
end

i_run_my_code_for_real = ($PROGRAM_NAME == __FILE__)
if i_run_my_code_for_real
  ## Convert the Braille back to normal text
  # Read Braille file
  braille_file = 'braille.txt'
  braille = File.read(braille_file)

  # Create a output file where the noraml text will be stored
  output_message = 'output_message.txt'
  message_output = File.open(output_message)

  # Print out message stating what file has been created and how many characters are in it.
  puts "Created '#{output_message}' containing #{num_of_characters} characters."

  # Convert the Braille file back to normal text
  normal_text = NightRead.new(braille).to_text

  # Write newly converted normal text to output file.
  output_message.write(normal_text)
end
