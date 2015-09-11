require 'pry'
require_relative '../lib/night_write'
require_relative '../lib/night_read'

class NightWriteTest < Minitest::Test
  def test_it_runs_in_command_line_with_no_errors
    `ruby ./lib/night_write.rb message.txt braille.txt`
    $?.success?
  end

  def test_it_imports_text_from_input_file
    writer = NightWrite.new
    file_name = 'message.txt'
    text = writer.get_text_from_file(file_name)
    assert_equal "This is another statement that I have to see if it will do the right thing", text
  end

  def test_it_outputs_message_with_new_file_name_and_number_of_characters_in_input_file
    writer = NightWrite.new
    message = 'braille.txt'
    command_line_message = writer.print_success_message(message)
    assert_equal "Created 'braille.txt' containing 10 characters.", command_line_message
  end

  def test_it_reads_text_from_input_file
    skip
  end

  def test_it_convert_lower_case_text_to_braille_letters
    assert_equal  "0.\n..\n..", NightWrite.new("a").to_braille

    assert_equal  "..0.0...00..0.\n....0...00..00\n.0.........0..", NightWrite.new("Ab gH").to_braille
  end

  def test_it_converts_capital_text_letters_to_capital_braille_letters
    assert_equal  "..0.\n....\n.0..", NightWrite.new("A").to_braille
  end

  def test_it_writes_to_a_new_line_after_80_braille_characters
    skip
    assert_equal
  end

  def test_it_writes_the_braille_into_the_output_file
    # ASK JOSH!
    skip
    writer = NightWrite.new('A')
    output_file = "braille.txt"

    braille = writer.to_braille

    writer.send_braille_to_file(output_file, braille)
    output_text = File.read(output_file)

    assert_equal braille, output_text
  end

  def text_it_reads_a_text_character_from_a_file
    skip
  end

  def test_it_converts_a_lowercase_braille_character_to_a_text_character
    braille = ".0\n..\n.."
    converted = NightRead.convert_to_text(braille)
    assert_equal 'a', converted
  end
end
