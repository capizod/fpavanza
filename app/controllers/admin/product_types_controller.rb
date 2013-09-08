class Admin::ProductTypesController < Admin::ApplicationController
  before_filter "set_current_tab('admin/product_types')", :only => [ :index, :show ]

  load_resource

  # GET /product_types
  #----------------------------------------------------------------------------
  def index
    @product_types = @product_types.unscoped.paginate(:page => params[:page])
  end

  # GET /product_types/1
  #----------------------------------------------------------------------------
  def show
    respond_with(@product_type)
  end

  # GET /product_types/new
  #----------------------------------------------------------------------------
  def new
    respond_with(@product_type)
  end

  # GET /product_types/1/edit
  #----------------------------------------------------------------------------
  def edit
    respond_with(@product_type)
  end

  # POST /product_types
  #----------------------------------------------------------------------------
  def create
    @product_type.update_attributes(params[:product_type])

    respond_with(@product_type)
  end

  # PUT /product_types/1
  #----------------------------------------------------------------------------
  def update
    @product_type.update_attributes(params[:product_type])

    respond_with(@product_type)
  end

  # DELETE /product_types/1
  #----------------------------------------------------------------------------
  def destroy
    @product_type.destroy

    respond_with(@product_type)
  end
end

