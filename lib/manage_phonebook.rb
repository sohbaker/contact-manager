class ManagePhonebook
  require 'person'
  require 'contact_manager'
  require 'json'

  attr_reader :contacts, :json_data, :find_contact, :store, :load_data

  def initialize
    refresh_data
  end

  def add_a_new_contact(first_name, last_name, email, phone)
    refresh_data
    load_JSON_file
    new_person = Person.new(first_name, last_name, email, phone)
    @load_data << (new_person.phonebook_entry)

    File.write('./lib/contacts.json', @load_data.to_json)
    clear_screen
  end

  def delete_existing_contact(name_of_contact)
    refresh_data
    load_JSON_file
    @delete_the_contact = @contacts.delete_if { |fn, ln, em, p| fn[:fname] == "#{name_of_contact}"}
    File.write('./lib/contacts.json', @delete_the_contact.to_json)
    # returning "true" instead of "contact deleted"
    if @delete_the_contact != false
      "contact deleted"
    else
      "this person isn't in your phonebook"
    end
    clear_screen
  end

  def alphabetise_contacts
    clear_screen
    refresh_data
    @sorted_list = @contacts.sort_by { |fn, ln, em, ph| fn[:fname]}
    return @sorted_list
    clear_screen
  end

  def search_phonebook(search_for)
    refresh_data
    @find_contact = @contacts.find_all { |y| y[:fname] == "#{search_for}"}
    return @find_contact.to_s
    clear_screen
  end

  def edit_which_detail(name_of_contact)
    clear_screen
    refresh_data
    load_JSON_file
    @contact_to_edit = @contacts.find { |y| y[:fname] == "#{name_of_contact}"}

    print "\nWould you like to edit their (1) first name, (2) surname, (3) email address or (4) mobile number?\n> "
    detail_to_change = gets.chomp
    print "What would you like to change it to?\n> "
    change_to = gets.chomp

    delete_previous_record = @contacts.delete_if { |fn, ln, em, p| fn[:fname] == "#{name_of_contact}"}
    File.write('./lib/contacts.json', delete_previous_record.to_json)

    edit_contact(detail_to_change, change_to)
  end

  def edit_contact(detail_to_change, change_to)
    refresh_data
    load_JSON_file

        if detail_to_change == "1"
          @contact_to_edit[:fname] = "#{change_to}"
        elsif detail_to_change == "2"
          @contact_to_edit[:sname] = "#{change_to}"
        elsif detail_to_change == "3"
          @contact_to_edit[:email_address] = "#{change_to}"
        elsif detail_to_change == "4"
          @contact_to_edit[:telephone] = "#{change_to}"
        end

      @load_data << @contact_to_edit
      File.write('./lib/contacts.json', @load_data.to_json)
      edit_complete
  end

  def edit_complete
    clear_screen
    return "\ncontact updated"
  end

  private # available within the class, but other classes can't see it

  def refresh_data # called a helper method (is helping you to use less code and dealing with something so that your other methods don't have to)
    @json_data = File.read('./lib/contacts.json')
    @contacts = JSON.parse(@json_data, {:symbolize_names => true})
  end

  def load_JSON_file
    @load_data = JSON.load(@json_data)
  end

  def clear_screen
    system('clear')
  end

end
