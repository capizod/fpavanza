class Admin::ProductStatesController < Admin::ApplicationController
  before_filter "set_current_tab('admin/product_states')", :only => [ :index, :show ]

  load_resource

  # GET /product_states
  #----------------------------------------------------------------------------
  def index
    @product_states = @product_states.unscoped.paginate(:page => params[:page])
  end

  # GET /product_states/1
  #----------------------------------------------------------------------------
  def show
    respond_with(@product_state)
  end

  # GET /product_states/new
  #----------------------------------------------------------------------------
  def new
    respond_with(@product_state)
  end

  # GET /product_states/1/edit
  #----------------------------------------------------------------------------
  def edit
    respond_with(@product_state)
  end

  # POST /product_states
  #----------------------------------------------------------------------------
  def create
    @product_state.update_attributes(params[:product_state])

    respond_with(@product_state)
  end

  # PUT /product_states/1
  #----------------------------------------------------------------------------
  def update
    @product_state.update_attributes(params[:product_state])

    respond_with(@product_state)
  end

  # DELETE /product_states/1
  #----------------------------------------------------------------------------
  def destroy
    @product_state.destroy

    respond_with(@product_state)
  end  
end
