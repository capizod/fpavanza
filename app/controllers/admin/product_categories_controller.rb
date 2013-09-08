class Admin::ProductCategoriesController < Admin::ApplicationController
  before_filter "set_current_tab('admin/product_categories')", :only => [ :index, :show ]

  load_resource

  # GET /product_categories
  #----------------------------------------------------------------------------
  def index
    @product_categories = @product_categories.unscoped.paginate(:page => params[:page])
  end

  # GET /product_categories/1
  #----------------------------------------------------------------------------
  def show
    respond_with(@product_category)
  end

  # GET /product_categories/new
  #----------------------------------------------------------------------------
  def new
    respond_with(@product_category)
  end

  # GET /product_categories/1/edit
  #----------------------------------------------------------------------------
  def edit
    respond_with(@product_category)
  end

  # POST /product_categories
  #----------------------------------------------------------------------------
  def create
    @product_category.update_attributes(params[:product_category])

    respond_with(@product_category)
  end

  # PUT /product_categories/1
  #----------------------------------------------------------------------------
  def update
    @product_category.update_attributes(params[:product_category])

    respond_with(@product_category)
  end

  # DELETE /product_categories/1
  #----------------------------------------------------------------------------
  def destroy
    @product_category.destroy

    respond_with(@product_category)
  end
end

