require 'spec_helper'

describe UsersController do

  describe "GET 'upgrade'" do
    it "returns http success" do
      get 'upgrade'
      response.should be_success
    end
  end

end
