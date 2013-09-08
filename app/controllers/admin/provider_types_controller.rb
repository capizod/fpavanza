class Admin::ProviderTypesController < Admin::ApplicationController
  before_filter "set_current_tab('admin/provider_types')", :only => [ :index, :show ]

  load_resource

  # GET /provider_types
  #----------------------------------------------------------------------------
  def index
    @provider_types = @provider_types.unscoped.paginate(:page => params[:page])
  end

  # GET /provider_types/1
  #----------------------------------------------------------------------------
  def show
    respond_with(@provider_type)
  end

  # GET /provider_types/new
  #----------------------------------------------------------------------------
  def new
    respond_with(@provider_type)
  end

  # GET /provider_types/1/edit
  #----------------------------------------------------------------------------
  def edit
    respond_with(@provider_type)
  end

  # POST /provider_types
  #----------------------------------------------------------------------------
  def create
    @provider_type.update_attributes(params[:provider_type])

    respond_with(@provider_type)
  end

  # PUT /provider_types/1
  #----------------------------------------------------------------------------
  def update
    @provider_type.update_attributes(params[:provider_type])

    respond_with(@provider_type)
  end

  # DELETE /provider_types/1
  #----------------------------------------------------------------------------
  def destroy
    @provider_type.destroy

    respond_with(@provider_type)
  end  
end
