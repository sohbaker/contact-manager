class ManagePhonebook
  require 'person'
  require 'contact_manager'
  require 'json'

  attr_reader :log_to_phonebook, :search, :json_data, :find_contact, :store

  def initialize
    @json_data = File.read('/Users/siobhanbaker/Documents/TDD/contact-manager/lib/contacts.json')
    @search = JSON.parse(@json_data, {:symbolize_names => true})
    @log_to_phonebook = []
  end

  def add_to_phonebook()
    @load_data = JSON.load(@json_data)

    new_person = Person.new(first_name, last_name, email, phone)
    @log_to_phonebook << (new_person.phonebook_entry)
    @load_data << (new_person.phonebook_entry)

    File.write('/Users/siobhanbaker/Documents/TDD/contact-manager/lib/contacts.json', @load_data.to_json)
  end

  def alphabetise_contacts
    @sorted_list = @search.sort_by { |fn, ln, em, p| fn[:fname]}
    return @sorted_list
  end

  def search_phonebook()
    @find_contact = @log_to_phonebook.find_all { |y| y[:fname] == "#{search_for}"}
    return @find_contact
  end
end
