require 'person'

RSpec.describe Person do
  it 'returns the details of the first contact' do
  new_contact = Person.new('bob', 'jones', 'bob@bob.com', '123456789')

  info = new_contact.phonebook_entry

  expect(info).to eq({:fname => 'bob', :sname => 'jones', :email_address => 'bob@bob.com', :telephone => '123456789'})
  e


  # it 'returns a certain set of requested details' do
  #   new_contact = Person.new('bob', 'jones', 'bob@bob.com', '123456789')
  #   new_contact = Person.new('sally', 'johnson', 'sally@sally.com', '456789123')
  #   new_contact = Person.new('hector', 'smith', 'hector@hector.com', '789123456')
  #
  #   info = new_contact.phonebook_entry
  #
  #   expect(info).to eq({:fname => 'sally', :sname => 'johnson', :email_address => 'sally@sally.com', :telephone => '456789123'})
  # end
end
