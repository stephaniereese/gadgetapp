require 'spec_helper' 

describe GadgetsController do 

	describe "GET #index" do 
		context "with all user gadgets" do 
			gadget = FactoryGirl(:gadget)
			user = FactoryGirl(:user)
			get :index
		end
	end 

end