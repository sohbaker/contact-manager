class ManagePhonebook
  require 'person'
  require 'contact_manager'
  require 'json'

  attr_reader :contacts, :json_data, :find_contact, :store, :load_data

  def initialize
    refresh_data
  end

  def add_to_phonebook(first_name, last_name, email, phone)
    refresh_data
    @load_data = JSON.load(@json_data)

    new_person = Person.new(first_name, last_name, email, phone)
    @load_data << (new_person.phonebook_entry)

    File.write('./lib/contacts.json', @load_data.to_json)
  end

  def delete_contact(delete)
    refresh_data
    @load_data = JSON.load(@json_data)
    @delete_the_contact = @contacts.delete_if { |fn, ln, em, p| fn[:fname] == "#{delete}"}
    File.write('./lib/contacts.json', @delete_the_contact.to_json)

    if @delete_the_contact != nil
      "contact deleted"
    else
      "this person isn't in your phonebook"
    end
  end

  def alphabetise_contacts
    refresh_data
    @sorted_list = @contacts.sort_by { |fn, ln, em, p| fn[:fname]}
    return @sorted_list
  end

  def search_phonebook(search_for)
    refresh_data
    @find_contact = @contacts.find_all { |y| y[:fname] == "#{search_for}"}
    return @find_contact.to_s
  end

  private # available within the class, but other classes can't see it

  def refresh_data # called a helper method (is helping you to use less code and dealing with something so that your other methods don't have to)
    @json_data = File.read('./lib/contacts.json')
    @contacts = JSON.parse(@json_data, {:symbolize_names => true})
  end

end
