require 'person'

RSpec.describe Person do
  it 'returns the details of the first contact' do
    new_contact = Person.new('bob', 'jones', 'bob@bob.com', '123456789')

    info = new_contact.phonebook_entry

    expect(info).to eq({:fname => 'bob', :sname => 'jones', :email_address => 'bob@bob.com', :telephone => '123456789'})
  end

end
