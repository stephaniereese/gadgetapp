class GadgetsController < ApplicationController
	before_action :authenticate_user!
	before_action :set_gadget, only: [:edit, :update, :destroy]



	def index
		if params[:q]
			@search_string = params[:q]
			@query_string = @search_string.gsub(/[^0-9a-z ]/i, '')
			logger.info "@query_string: " + @query_string
			@gadgets = Gadget.find_by_sql("select * from gadgets where (name like '%#{@query_string}%' or manufacturer like '%#{@query_string}%') and user_id = #{current_user.id} order by created_at DESC")
		else
			@gadgets = Gadget.where("user_id" => current_user.id)
			@images = Image.find_by_sql("select * from gadgets g, images i where i.gadget_id = g.id and g.user_id = #{current_user.id}")
		end
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
		respond_to do |format|
      if @gadget.update(gadget_params)
        format.html { redirect_to gadgets_url, notice: 'Gadget was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
	end

	def destroy
		@gadget.destroy
    redirect_to gadgets_url
	end

  private
    def set_gadget
      @gadget = Gadget.find(params[:id])
    end

    def gadget_params
      params.require(:gadget).permit(:name, :manufacturer, :retired)
    end

end
