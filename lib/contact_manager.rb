class ContactManager
  require 'manage_phonebook'
  require 'colorize'

  attr_reader :manage_phonebook

  def initialize
    @manage_phonebook = ManagePhonebook.new()
  end

  def greet_user
    @manage_phonebook.greeting_message
    program_options()
  end

  def program_options
    @manage_phonebook.display_options
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
      @manage_phonebook.closing_message
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
    @manage_phonebook.sort_contacts_alphabetically()
    program_options()
  end

  def option_search
    @manage_phonebook.search_phonebook()
    program_options()
  end

  def option_edit_contact
    @manage_phonebook.edit_which_detail()
    program_options()
  end

  def user_exits_program
    @user_response.include?('6') == true
  end

end

contact_manager = ContactManager.new
contact_manager.greet_user
