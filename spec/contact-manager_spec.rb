require 'contact_manager'
require 'json'

RSpec.describe ContactManager do

  it 'stores details of new contact' do
   allow($stdin).to receive(:gets).and_return("Shivs", "B", "sio@bhan.com", "123456789")
   new_contact = ContactManager.new

   new_contact.add_to_phonebook

   expect(new_contact.log_to_phonebook).to eq([{:fname => 'Shivs', :sname => 'B', :email_address => 'sio@bhan.com', :telephone => '123456789'}])
  end

  it 'returns details of multiple contacts' do
   allow($stdin).to receive(:gets).and_return('Shivs', "B", "sio@bhan.com", "123456789", "Jeff", "J", "jeff@rey.com", "987654321")
   new_contact = ContactManager.new

   new_contact.add_to_phonebook
   new_contact.add_to_phonebook

   expect(new_contact.log_to_phonebook).to eq([{:fname => 'Shivs', :sname => 'B', :email_address => 'sio@bhan.com', :telephone => '123456789'}, {:fname => 'Jeff', :sname => 'J', :email_address => 'jeff@rey.com', :telephone => '987654321'}])
  end

  it 'sorts contacts alphabetically' do
   allow($stdin).to receive(:gets).and_return("Jeff", "J", "jeff@rey.com", "987654321")
   new_contact = ContactManager.new

   expect(new_contact.alphabetise).to eq([{:fname => 'Jeff', :sname => 'J', :email_address => 'jeff@rey.com', :telephone => '987654321'}, {:fname => 'Shivs', :sname => 'B', :email_address => 'sio@bhan.com', :telephone => '123456789'}])
  end

  it 'allow you to search for and return a contact' do
   allow($stdin).to receive(:gets).and_return("Hector","Smith","hector@hector.com","78912345", "Hector")
   new_contact = ContactManager.new

   new_contact.add_to_phonebook

   expect(new_contact.search_phonebook).to eq([{:fname => 'Hector', :sname => 'Smith', :email_address => 'hector@hector.com', :telephone => '78912345'}])
  end
end
