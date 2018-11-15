class ContactManager
  require 'manage_phonebook'

  attr_reader :options_menu, :phonebook

  @@manage_phonebook = ManagePhonebook.new()

  def greet_user
    print "Welcome to you Contact Manager, a command line program which allows you to store, search and view your contacts\nYou can choose to: \n\u2460 add a new contact \n\u2461 view all your contacts, listed alphabetically \n\u2462 search for a contact, or \n\u2463 exit this program\n"

    use_the_phonebook()
  end

  def use_the_phonebook
    print "Would you like to: (1)add a contact, (2)view your contacts, (3)search or (4)exit?\n> "
    @user_response = gets.chomp

    while user_exits_program() == false
      if @user_response == "1"
        option_add_contact()
      elsif @user_response == "2"
        option_view_contacts()
      elsif @user_response == "3"
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
    email = gets.chomp
    print "What is the person's contact telephone number?\n> "
    phone = gets.chomp

    @@manage_phonebook.add_to_phonebook(first_name, last_name, email, phone)
    print "contact added\n"
    return use_the_phonebook()
  end

  def option_view_contacts
    # @@manage_phonebook.alphabetise_contacts()
    print @@manage_phonebook.alphabetise_contacts()
    print "\n"
    print use_the_phonebook()
  end

  def option_search
    puts "What is the first name of the person you like to find?"
    search_for = gets.chomp

    @@manage_phonebook.search_phonebook(search_for)
    print @@manage_phonebook.search_phonebook(search_for)
    print "\n"
    print use_the_phonebook()
  end

  def user_exits_program
    @user_response.include?('4') == true
  end
end

contact_manager = ContactManager.new
contact_manager.greet_user
