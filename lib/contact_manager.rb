class ContactManager
  require 'person'

  attr_reader :store_entries, :first_name, :surname, :email, :phonenumber

  def initialize
    @store_entries = []
  end

  def add_to_phonebook
    puts "What is your first name?"
    first_name = $stdin.gets.chomp
    puts "What is your surname?"
    last_name = $stdin.gets.chomp
    puts "What is your email address?"
    email = $stdin.gets.chomp
    puts "What is your contact telephone number?"
    phone = $stdin.gets.chomp

    new_person = Person.new(first_name, last_name, email, phone)
    @store_entries.push(new_person.phonebook_entry)
  end

  def alphabetise
    @sorted_list = @store_entries.sort_by { |fn, ln, em, pn | fn[:fname]}
  end

  def search_phonebook
    puts "What is the first name of the person you like to find?"
    search_for = $stdin.gets.chomp
    
    find_contact = @store_entries.find_all { |y| y[:fname] == "#{search_for}"}
    p find_contact
  end
end
