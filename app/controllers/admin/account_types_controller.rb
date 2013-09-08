#------------------------------------------------------------------------------
class Admin::AccountTypesController < Admin::ApplicationController
  before_filter "set_current_tab('admin/account_types')", :only => [ :index, :show ]

  load_resource

  # GET /account_types
  #----------------------------------------------------------------------------
  def index
    @account_types = @account_types.unscoped.paginate(:page => params[:page])
  end

  # GET /account_types/1
  #----------------------------------------------------------------------------
  def show
    respond_with(@account_type)
  end

  # GET /account_types/new
  #----------------------------------------------------------------------------
  def new
    respond_with(@account_type)
  end

  # GET /account_types/1/edit
  #----------------------------------------------------------------------------
  def edit
    respond_with(@account_type)
  end

  # POST /account_types
  #----------------------------------------------------------------------------
  def create
    @account_type.update_attributes(params[:account_type])

    respond_with(@account_type)
  end

  # PUT /account_types/1
  #----------------------------------------------------------------------------
  def update
    @account_type.update_attributes(params[:account_type])

    respond_with(@account_type)
  end

  # DELETE /account_types/1
  #----------------------------------------------------------------------------
  def destroy
    @account_type.destroy

    respond_with(@account_type)
  end
end
