require 'rails_helper'

module Sparql
  module Get

    describe "GET Response", type: :view do
      it "does a more end to end test" do

        params = "params"
        string = "Civil Aviation (Air Travel Organisers\xE2\x80\x99 Licensing".force_encoding(Encoding::ASCII_8BIT)

        class TestObject
          include Sparql::Get::Response

          def initialize
            @queries = []
          end
        end

        obj = TestObject.new
        response = instance_double(Net::HTTPResponse)
        expect(response).to receive(:body).and_return(string)
        expect(obj).to receive(:call_api).with(params).and_return(response)
        output = obj.get_sparql_response_as_csv(params)

        assign(:title, output.to_s)

        # This should not blow up
        render inline: <<~ERB
          <title>
            UTF-8 literal: “foo”
            <%= @title.html_safe %>
          </title>
        ERB
      end

      it "blows up on render" do
        # UTF-8 bytes (right single quote) but tagged ASCII-8BIT
        bad_title = "Civil Aviation (Air Travel Organisers\xE2\x80\x99 Licensing"
        bad_title.force_encoding(Encoding::ASCII_8BIT)

        assign(:title, bad_title)

        # This MUST be wrapped — the exception happens *inside* render
        expect {
          render inline: <<~ERB
            <title>
              UTF-8 literal: “foo”
              <%= @title.html_safe %>
            </title>
          ERB

          }.to raise_error(ActionView::Template::Error) { |err|
            # Check the original cause is the encoding error
            expect(err.cause).to be_a(Encoding::CompatibilityError)
          }
      end
    end
  end
end
