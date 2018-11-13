require 'contact_manager'

RSpec.describe ContactManager do

  # it 'returns no details when given no information' do
  # new_contact = ContactManager.new(' ')
  #
  # info = new_contact.info
  #
  # expect(info).to eq(' ')
  # end

  it 'stores details of new contact' do
   allow($stdin).to receive(:gets).and_return("Shivs", "B", "sio@bhan.com", "123456789")
   new_contact = ContactManager.new

   new_contact.add_to_phonebook

   expect(new_contact.store_entries).to eq([{:fname => 'Shivs', :sname => 'B', :email_address => 'sio@bhan.com', :telephone => '123456789'}])
  end

  it 'return details of multiple contacts' do
   allow($stdin).to receive(:gets).and_return("Shivs", "B", "sio@bhan.com", "123456789", "Jeff", "J", "jeff@rey.com", "987654321")
   new_contact = ContactManager.new

   new_contact.add_to_phonebook
   new_contact.add_to_phonebook

   expect(new_contact.store_entries).to eq([{:fname => 'Shivs', :sname => 'B', :email_address => 'sio@bhan.com', :telephone => '123456789'}, {:fname => 'Jeff', :sname => 'J', :email_address => 'jeff@rey.com', :telephone => '987654321'}])
  end
end
