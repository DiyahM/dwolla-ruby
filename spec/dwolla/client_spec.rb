require 'spec_helper'

describe Dwolla::Client do
  subject { Dwolla::Client.new('sample_client_id', 'sample_client_secret') }
  let(:query_params) { "client_id=sample_client_id&client_secret=sample_client_secret" }

  describe "getting user basic information" do
    before do
      stub_get('/users/812-111-1111', query_params).
        to_return(:body => fixture("basic_information.json"))
    end

    it 'should request the correct resource' do
      subject.user('812-111-1111')
      a_get('/users/812-111-1111', query_params).should have_been_made
    end

    it 'should return extended information of a given user' do
      user = subject.user('812-111-1111')
      user.should be_a Dwolla::User
      user.id.should == '812-111-1111'
      user.name.should == 'Test User'
      user.latitude.should == 41.584546
      user.longitude.should == -93.634167
    end
  end

  describe "create offsite checkout" do
    let(:order_item) { OrderItem.new({name: 'Item1', description: 'description1', price: 2.25, quantity: 6}) }
    let(:cart) { Cart.new({allow_funding_sources: true, destination_id: '812-111-1111', discount: 0.10, tax: 0.00,
                          shipping: 1.00, total: 3.25}) }
    before do
      stub_request(:post, "https://www.dwolla.com/payment/request").
                   to_return(:status => 200,
                             :body => fixture("offsite_gateway_success_response.json"))
    end
    it 'should return the checkout id of a new session' do
      cart.add_order_item(order_item)
      subject.create_offsite_checkout(cart).should eq "C3D4DC4F-5074-44CA-8639-B679D0A70803"
    end
  end
end
