class GadgetsController < ApplicationController
	before_action :authenticate_user!


	def index
		@gadgets = Gadget.where("user_id" => current_user.id)
	end

	def new
		@gadget = Gadget.new
	end

	def edit
	end

	def create
		@gadget = Gadget.new(gadget_params)

	  if @gadget.save
	  	@gadget.user_id = current_user.id
	  	@gadget.save
	  	if params[:images]
        params[:images].each { |image|
          @gadget.images.create(photo: image)
        }
      end
	    redirect_to gadgets_url, notice: 'Gadget was successfully created.'
	  else
	    render action: 'new', notice: 'Gadget was not created.'
	  end
	end

	def update
	end

	def destroy
	end

  private
    def set_user
      @gadget = Gadget.find(params[:id])
    end

    def gadget_params
      params.require(:gadget).permit(:name, :manufacturer, :retired)
    end

    def image_params
    end

end
