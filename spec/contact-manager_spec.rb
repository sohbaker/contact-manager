require 'contact-manager'

# RSpec.describe ContactManager do
#
#   it 'returns no name when given no information' do
#   new_contact = ContactManager.new(' ')
#
#   info = new_contact.info
#
#   expect(info).to eq(' ')
#   end
#
# end

RSpec.describe Person do
  it 'returns the details of the first contact' do
  new_contact = Person.new('bob', 'bob@bob.com', '123456789')

  info = new_contact.personal_details

  expect(info).to eq('bob''bob@bob.com''123456789')
  end
end
