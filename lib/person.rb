class Person
  attr_reader :first_name, :surname, :email, :phonenumber

  def initialize(f_name, s_name, email, phonenumber)
    @f_name = f_name
    @s_name = s_name
    @email = email
    @phonenumber = phonenumber
  end

  def phonebook_entry
    {
      :fname => @f_name,
      :sname => @s_name,
      :email => @email,
      :mobile => @phonenumber
    }
  end

end
