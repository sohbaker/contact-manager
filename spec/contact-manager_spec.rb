require 'contact-manager'

RSpec.describe ContactManager do

  it 'returns no name when given no information' do
  new_contact = ContactManager.new(' ')

  info = new_contact.info

  expect(info).to eq(' ')
  end

end
