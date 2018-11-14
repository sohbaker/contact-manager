require 'contact_manager'
require 'json'
require "json_spec"
require 'spec_helper'

RSpec.configure do |config|
  config.include JsonSpec::Helpers

  describe ContactManager do

    context "#to_json" do
      it 'stores details of new contact' do
       let(:gets){ ContactManager.create!(fname: "Shivs", sname: "B", email_address: "sio@bhan.com", telephone: "123456789") }
       new_contact = %({":fname":"Shivs",":sname":"B",":email_address":"sio@bhan.com",":telephone":"123456789"})

       gets.to_json.should be_json_eql(new_contact)

       # expect(new_contact.store_entries).to eq([{:fname => 'Shivs', :sname => 'B', :email_address => 'sio@bhan.com', :telephone => '123456789'}])
      end
    end

  end
end
