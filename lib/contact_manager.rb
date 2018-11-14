class ContactManager
  require 'person'
  require 'json'

  attr_reader :log_to_phonebook, :search, :json_data, :find_contact, :store

  def initialize
    @json_data = File.read('/Users/siobhanbaker/Documents/TDD/contact-manager/lib/contacts.json')
    @search = JSON.parse(@json_data, {:symbolize_names => true})
    @log_to_phonebook = []
  end

  def add_to_phonebook
    @load_data = JSON.load(@json_data)

    puts "What is your first name?"
    first_name = $stdin.gets.chomp
    puts "What is your surname?"
    last_name = $stdin.gets.chomp
    puts "What is your email address?"
    email = $stdin.gets.chomp
    puts "What is your contact telephone number?"
    phone = $stdin.gets.chomp

    new_person = Person.new(first_name, last_name, email, phone)
    @log_to_phonebook << (new_person.phonebook_entry)
    @load_data << (new_person.phonebook_entry)

    File.write('/Users/siobhanbaker/Documents/TDD/contact-manager/lib/contacts.json', @load_data.to_json)

    p log_to_phonebook

  end

  def alphabetise
    @sorted_list = @search.sort_by { |fn, ln, em, p| fn[:fname]}
    return @sorted_list
  end

  def search_phonebook
    puts "What is the first name of the person you like to find?"
    search_for = $stdin.gets.chomp

    @find_contact = @log_to_phonebook.find_all { |y| y[:fname] == "#{search_for}"}
    p @find_contact
  end
end
