class ContactManager
  require 'person'

  attr_reader :store_entries

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

  def greet_user

  end
end
