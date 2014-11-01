require 'rails_helper'

RSpec.describe ResponsesController do
  describe "POST add" do
    it 'accepts a standard params structure'

    context 'with a registered pebble_token' do
      it 'saves the response to database'
      it 'returns 200'
      it 'triggers analysis'
    end

    context 'with an unregistered pebble_token' do
      it 'does not save the response to database'
      it 'returns 403'
    end
  end
end