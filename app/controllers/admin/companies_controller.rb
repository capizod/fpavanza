class Admin::CompaniesController < Admin::ApplicationController
  before_filter "set_current_tab('admin/companies')", :only => [ :index, :show ]

  load_resource

  # GET /companies
  #----------------------------------------------------------------------------
  def index
    @companies = @companies.unscoped.paginate(:page => params[:page])
  end

  # GET /companies/1
  #----------------------------------------------------------------------------
  def show
    respond_with(@company)
  end

  # GET /companies/new
  #----------------------------------------------------------------------------
  def new
    respond_with(@company)
  end

  # GET /companies/1/edit
  #----------------------------------------------------------------------------
  def edit
    respond_with(@company)
  end

  # POST /companies
  #----------------------------------------------------------------------------
  def create
    @company.update_attributes(params[:company])

    respond_with(@company)
  end

  # PUT /companies/1
  #----------------------------------------------------------------------------
  def update
    @company.update_attributes(params[:company])

    respond_with(@company)
  end

  # DELETE /companies/1
  #----------------------------------------------------------------------------
  def destroy
    @company.destroy

    respond_with(@company)
  end  
end
