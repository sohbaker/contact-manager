class ContactManager
  require 'manage_phonebook'
  require 'colorize'

  attr_reader :manage_phonebook

  def initialize
    @manage_phonebook = ManagePhonebook.new()
  end

  def greet_user
    print "Welcome to your Contact Manager, a command line program which allows you to store, search and view your contacts.\nYou can choose to:\n\u2460 add a new contact\n\u2461 edit a contact's details \n\u2462 delete a contact \n\u2463 view all your contacts, listed alphabetically \n\u2464 search for a contact, or \n\u2465 exit this program\n"
    program_options()
  end

  def program_options
    print "\nWould you like to: (1) add a contact, (2) edit a contact, (3) delete a contact, (4) view your contacts, (5) search, or (6) exit?\n> ".magenta.on_blue
    @user_response = gets.chomp

    while user_exits_program() == false
      if @user_response == "1"
        option_add_contact()
      elsif @user_response == "2"
        option_edit_contact()
      elsif @user_response == "3"
        option_delete_contact()
      elsif @user_response == "4"
        option_view_contacts()
      elsif @user_response == "5"
        option_search()
      else
        puts "please enter a valid number"
        program_options()
      end
    end

    if user_exits_program() == true
      print "Thanks for using the Contact Manager\n".blue.on_green.blink
      exit(0)
    end
  end

  def option_add_contact
    @manage_phonebook.add_a_new_contact()
    program_options()
  end

  def option_delete_contact
    @manage_phonebook.delete_existing_contact()
    program_options()
  end

  def option_view_contacts
    print @manage_phonebook.sort_contacts_alphabetically()
    program_options()
  end

  def option_search
    print @manage_phonebook.search_phonebook()
    program_options()
  end

  def option_edit_contact
    print @manage_phonebook.edit_which_detail()
    program_options()
  end

  def user_exits_program
    @user_response.include?('6') == true
  end

end

contact_manager = ContactManager.new
contact_manager.greet_user
