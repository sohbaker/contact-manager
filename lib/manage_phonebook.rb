class ManagePhonebook
  require 'person'
  require 'contact_manager'
  require 'json'
  require 'colorize'
  require 'colorized_string'
  require 'awesome_print'
  require 'display'

  attr_reader :json_data, :load_data

  def initialize
    read_JSON_file
    @print_to_console = Display.new
  end

  def greeting_message
    @print_to_console.display("Welcome to your Contact Manager, a command line program which allows you to store, search and view your contacts.\nYou can choose to:\n\u2460 add a new contact\n\u2461 edit a contact's details \n\u2462 delete a contact \n\u2463 view all your contacts, listed alphabetically \n\u2464 search for a contact, or \n\u2465 exit this program\n")
  end

  def display_options
    @print_to_console.display("\nWould you like to: (1) add a contact, (2) edit a contact, (3) delete a contact, (4) view your contacts, (5) search, or (6) exit?\n> ".magenta.on_blue)
  end

  def add_a_new_contact
    read_JSON_file
    load_JSON_file

    @print_to_console.display("What is the person's first name?\n> ")
    first_name = gets.chomp
    @print_to_console.display("What is the person's surname?\n> ")
    last_name = gets.chomp
    @print_to_console.display("What is the person's email address?\n> ")
    check_email()
    @print_to_console.display("What is the person's mobile number?\n> ")
    check_phone()

    new_person = Person.new(first_name, last_name, @email, @phonenumber)
    @load_data << (new_person.phonebook_entry)

    File.write('./lib/contacts.json', @load_data.to_json)
    clear_screen
    @print_to_console.display("Contact added: #{new_person.phonebook_entry}\n".green)
  end

  def delete_existing_contact
    clear_screen
    read_JSON_file
    load_JSON_file

    @print_to_console.display("What is the first name of the person whose details you like to delete?\n> ")
    name_of_contact = gets.chomp
    @find_contact_to_delete = @contacts.find_all { |y| y[:fname] == "#{name_of_contact}"}
    clear_screen()

    if @find_contact_to_delete.count >= 1
      @print_to_console.display("Are you sure you want to delete: #{@find_contact_to_delete}?\n(1) Yes or (2) No\n> ".on_red)
      delete_check = gets.chomp
      if delete_check == "1"
        delete = @contacts.delete_if { |fn, ln, em, p| fn[:fname] == "#{name_of_contact}"}
        @print_to_console.display("Contact deleted\n".red)
        File.write('./lib/contacts.json', delete.to_json)
      elsif delete_check == "2"
        @print_to_console.display("returning to main menu")
      end
    else
      return "This person: '#{name_of_contact}' isn\'t in your Contact Manager"
    end
  end

  def sort_contacts_alphabetically
    clear_screen
    read_JSON_file
    @print_to_console.display("Would you like to sort your contacts by (1) first name, or (2) surname?\n> ")
    sort_first_or_last = gets.chomp

    if sort_first_or_last == "1" || sort_first_or_last == "2"
      @print_to_console.display("Here are all the contacts in your Contact Manager:\n")
      if sort_first_or_last == "1"
        return ap @contacts.sort_by { |fn, ln, em, ph| fn[:fname]}
      elsif sort_first_or_last == "2"
        return ap @contacts.sort_by { |fn, ln, em, ph| fn[:sname]}
      end
    else
      "Please select a valid option"
    end
  end

  def search_phonebook
    clear_screen
    @print_to_console.display("What is the first name of the person you like to find?\n> ")
    search_for = gets.chomp
    read_JSON_file
    @find_contact = @contacts.find_all { |y| y[:fname] == "#{search_for}"}
    if @find_contact.length >= 1
      return @find_contact.to_s.on_green
    else
      return @print_to_console.display("This person: '#{search_for}' isn\'t in your Contact Manager\n".red)
    end
  end

  def edit_which_detail
    clear_screen
    @print_to_console.display("What is the first name of the person whose details you would like to change?\n> ")
    name_of_contact = gets.chomp
    read_JSON_file
    load_JSON_file
    @contact_to_edit = @contacts.find { |y| y[:fname] == "#{name_of_contact}"}

    if @contact_to_edit == nil
      return "Couldn\'t find that contact, please try again\n"
    else
      @print_to_console.display(@contact_to_edit.to_s.red.on_white)
      @print_to_console.display("\nWould you like to edit their (1) first name, (2) surname, (3) email address or (4) mobile number?\n> ")
      detail_to_change = gets.chomp
      @print_to_console.display("What would you like to change it to?\n> ")
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
          @contact_to_edit[:email] = "#{change_to}"
        elsif detail_to_change == "4"
          @contact_to_edit[:mobile] = "#{change_to}"
        end

      @load_data << @contact_to_edit
      File.write('./lib/contacts.json', @load_data.to_json)

      clear_screen
      return "Contact updated: #{@contact_to_edit}\n".green
  end

  def closing_message
    @print_to_console.display("Thanks for using Contact Manager\n".blue.on_green.blink)
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
      @print_to_console.display("Please enter a valid email address\n> ")
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
      @print_to_console.display("Please enter a valid UK mobile phone number\n> ")
      check_phone()
      break if @is_valid_phone_no == true
    end
    return @phonenumber
  end

end
