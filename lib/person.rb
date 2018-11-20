class Person
  attr_reader :first_name, :surname, :email, :phonenumber

  def initialize(f_name, s_name, email, phonenumber)
    @first_name = f_name
    @surname = s_name
    @email = email
    @phonenumber = phonenumber
  end

  def add_name(first_name, last_name)
    @first_name = first_name
    @surname = last_name
  end

  def add_email(new_email)
    @email = new_email
  end

  def add_phone(new_number)
    @phonenumber = new_number
  end

  def phonebook_entry
    {
      :fname => @first_name,
      :sname => @surname,
      :email_address => @email,
      :mobile => @phonenumber
    }
  end

end
