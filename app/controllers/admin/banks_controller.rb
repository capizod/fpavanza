#------------------------------------------------------------------------------
class Admin::BanksController < Admin::ApplicationController
  before_filter "set_current_tab('admin/banks')", :only => [ :index, :show ]

  load_resource

  # GET /banks
  #----------------------------------------------------------------------------
  def index
    @banks = @banks.unscoped.paginate(:page => params[:page])
  end

  # GET /banks/1
  #----------------------------------------------------------------------------
  def show
    respond_with(@bank)
  end

  # GET /banks/new
  #----------------------------------------------------------------------------
  def new
    respond_with(@bank)
  end

  # GET /banks/1/edit
  #----------------------------------------------------------------------------
  def edit
    respond_with(@bank)
  end

  # POST /banks
  #----------------------------------------------------------------------------
  def create
    @bank.update_attributes(params[:bank])

    respond_with(@bank)
  end

  # PUT /banks/1
  #----------------------------------------------------------------------------
  def update
    @bank.update_attributes(params[:bank])

    respond_with(@bank)
  end

  # DELETE /banks/1
  #----------------------------------------------------------------------------
  def destroy
    @bank.destroy

    respond_with(@bank)
  end
end
