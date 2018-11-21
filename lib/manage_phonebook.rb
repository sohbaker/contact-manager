class ManagePhonebook
  require 'person'
  require 'contact_manager'
  require 'json'
  require 'colorize'
  require 'colorized_string'

  attr_reader :json_data, :load_data

  def initialize
    read_JSON_file
  end

  def add_a_new_contact
    read_JSON_file
    load_JSON_file

    print "What is the person's first name?\n> "
    first_name = gets.chomp
    print "What is the person's surname?\n> "
    last_name = gets.chomp
    print "What is the person's email address?\n> "
    check_email()
    print "What is the person's mobile number?\n> "
    check_phone()

    new_person = Person.new(first_name, last_name, @email, @phonenumber)
    @load_data << (new_person.phonebook_entry)

    File.write('./lib/contacts.json', @load_data.to_json)
    clear_screen
    print "contact added\n".green
  end

  def delete_existing_contact
    clear_screen
    read_JSON_file
    load_JSON_file

    puts "What is the first name of the person whose details you like to delete?"
    name_of_contact = gets.chomp
    @delete_the_contact = @contacts.delete_if { |fn, ln, em, p| fn[:fname] == "#{name_of_contact}"}

    if @delete_the_contact != false
      File.write('./lib/contacts.json', @delete_the_contact.to_json)
      return "contact deleted\n".red # this part isn't printing , but the contact is being deleted
    else
      return "this person isn't in your phonebook"
    end

    clear_screen
  end

  def sort_contacts_alphabetically
    clear_screen
    read_JSON_file
    @sorted_list = @contacts.sort_by { |fn, ln, em, ph| fn[:fname]}
    print "Here are all the contacts in your Contact Manager:\n"
    return @sorted_list
  end

  def search_phonebook
    clear_screen
    puts "What is the first name of the person you like to find?"
    search_for = gets.chomp
    read_JSON_file
    @find_contact = @contacts.find_all { |y| y[:fname] == "#{search_for}"}
    return @find_contact.to_s.green.on_white
  end

  def edit_which_detail
    clear_screen
    print "What is the first name of the person whose details you would like to change?\n"
    name_of_contact = gets.chomp
    read_JSON_file
    load_JSON_file
    @contact_to_edit = @contacts.find { |y| y[:fname] == "#{name_of_contact}"}

    if @contact_to_edit == nil
      return "couldn't find that contact, please try again"
    else
      print @contact_to_edit.to_s.red.on_white
      print "\nWould you like to edit their (1) first name, (2) surname, (3) email address or (4) mobile number?\n> "
      detail_to_change = gets.chomp
      print "What would you like to change it to?\n> "
      change_to = gets.chomp

      delete_previous_record = @contacts.delete_if { |fn, ln, em, p| fn[:fname] == "#{name_of_contact}"}
      File.write('./lib/contacts.json', delete_previous_record.to_json)

      edit_contact(detail_to_change, change_to)
    end
  end

  def edit_contact(detail_to_change, change_to)
    read_JSON_file
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
    return "contact updated: #{@contact_to_edit}\n".green
  end

  private # available within the class, but other classes can't see it

  def read_JSON_file # called a helper method (is helping you to use less code and dealing with something so that your other methods don't have to)
    @json_data = File.read('./lib/contacts.json')
    @contacts = JSON.parse(@json_data, {:symbolize_names => true})
  end

  def load_JSON_file
    @load_data = JSON.load(@json_data)
  end

  def clear_screen
    system('clear')
  end

  def check_email
    @email = gets.chomp
    email_as_characters = @email.chars
    @is_valid_email = email_as_characters.include?("@")

    while @is_valid_email == false
      print "Please enter a valid email address\n> "
      check_email()
      break if @is_valid_email == true
    end
    return @email
  end

  def check_phone
    @phonenumber = gets.chomp
    phone_number_as_digits = @phonenumber.chars
    @is_valid_phone_no = phone_number_as_digits[0] == "0" && phone_number_as_digits[1] == "7" && phone_number_as_digits.length == 11

    while @is_valid_phone_no == false
      print "Please enter a valid UK mobile phone number\n> "
      check_phone()
      break if @is_valid_phone_no == true
    end
    return @phonenumber
  end

end
