class Person
  attr_reader :first_name, :surname, :email, :phonenumber

  def initialize(f_name, s_name, email, phonenumber)
    @first_name = f_name
    @surname = s_name
    @email = email
    @phonenumber = phonenumber
  end

  def phonebook_entry
    {
      :fname => @first_name,
      :sname => @surname,
      :email => @email,
      :mobile => @phonenumber
    }
  end

end
