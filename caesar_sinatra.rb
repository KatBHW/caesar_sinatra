require 'sinatra'
require 'sinatra/reloader' if development?

get '/' do
  input = " "
  input = params['phrase'] if params['phrase']
  characters = input.scan(/./) 
  input_number = params['offset'].to_i
  offset = input_number % 26  #correct offsets greater than the length of the alphabet  
  translation = shift_letters(characters, offset) #join the coded letters array into a sentence
  erb :index, :locals => {:translation => translation, :input => input}  
end 

def shift_letters(characters, offset)
  lower_cases = ("a".."z")
  upper_cases = ("A".."Z")
  coded_letters = []
  characters.map do |letter|
    if lower_cases.include?(letter) 
      letter = letter.sum + offset #convert letter to ASCII value and add offset
      letter.between?(97,122)? letter = letter.chr : letter = (letter-26).chr #convert back to letter and wrap around alphabet  
    elsif upper_cases.include?(letter) 
      letter = letter.sum + offset
      letter.between?(65,90)? letter = letter.chr : letter = (letter-26).chr   
    else
      letter = letter #retain punctuation
    end
    coded_letters << letter #push each letter into an array of coded letters
  end
  coded_letters.join
end 