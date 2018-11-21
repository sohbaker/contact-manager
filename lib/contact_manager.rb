class ContactManager
  require 'manage_phonebook'
  require 'colorize'

  attr_reader :options_menu, :phonebook, :email, :phone, :manage_phonebook

  def initialize
    @manage_phonebook = ManagePhonebook.new()
  end

  def greet_user
    print "Welcome to your Contact Manager, a command line program which allows you to store, search and view your contacts.\nYou can choose to:\n\u2460 add a new contact\n\u2461 edit a contact's details \n\u2462 delete a contact \n\u2463 view all your contacts, listed alphabetically \n\u2464 search for a contact, or \n\u2465 exit this program\n"
    use_the_phonebook()
  end

  def use_the_phonebook
    print "Would you like to: (1) add a contact, (2) edit a contact, (3) delete a contact, (4) view your contacts, (5) search, or (6) exit?\n> ".magenta.on_blue
    @user_response = gets.chomp

    while user_exits_program() == false
      if @user_response == "1"
        option_add_contact()
      elsif @user_response == "2"
        option_edit()
      elsif @user_response == "3"
        option_delete_contact()
      elsif @user_response == "4"
        option_view_contacts()
      elsif @user_response == "5"
        option_search()
      end
    end

    if user_exits_program() == true
      exit(0)
    end
  end

  def option_add_contact
    print "What is the person's first name?\n> "
    first_name = gets.chomp
    print "What is the person's surname?\n> "
    last_name = gets.chomp
    print "What is the person's email address?\n> "
    @email = gets.chomp
      @check_email = @email.chars
      @is_valid_email = @check_email.include?("@")

      while @is_valid_email == false
        print "Please enter a valid email address\n> "
        @email = gets.chomp
        @check_email = @email.chars
        @is_valid_email = @check_email.include?("@")
        break if @is_valid_email == true
      end
    print "What is the person's mobile number?\n> "
    @phone = gets.chomp
      @check_phone = @phone.chars
      @is_valid_phone_no = @check_phone[0] == "0" && @check_phone[1] == "7" && @check_phone.length == 11

      while @is_valid_phone_no == false
        print "Please enter a valid UK mobile phone number\n> "
        @phone = gets.chomp
        @check_phone = @phone.chars
        @is_valid_phone_no = @check_phone[0] == "0" && @check_phone[1] == "7" && @check_phone.length == 11
        break if @is_valid_phone_no == true
      end

    @manage_phonebook.add_a_new_contact(first_name, last_name, @email, @phone)
    print "contact added\n".green
    print use_the_phonebook()
  end

  def option_delete_contact
    puts "What is the first name of the person whose details you like to delete?"
    delete = gets.chomp

    @manage_phonebook.delete_existing_contact(delete)
    print @manage_phonebook.delete_existing_contact(delete)
    print "\n"
    print use_the_phonebook()
  end

  def option_view_contacts
    print @manage_phonebook.alphabetise_contacts()
    print "\n"
    print use_the_phonebook()
  end

  def option_search
    puts "What is the first name of the person you like to find?"
    search_for = gets.chomp

    @manage_phonebook.search_phonebook(search_for)
    print @manage_phonebook.search_phonebook(search_for)
    print "\n"
    print use_the_phonebook()
  end

  def option_edit
    puts "What is the first name of the person whose details you would like to change?\n"
    name_of_contact = gets.chomp

    @manage_phonebook.edit_which_detail(name_of_contact)
    print @manage_phonebook.edit_complete
    print "\n"
    print use_the_phonebook()
  end

  def user_exits_program
    @user_response.include?('6') == true
  end

end

contact_manager = ContactManager.new
contact_manager.greet_user
