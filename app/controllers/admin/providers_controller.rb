#------------------------------------------------------------------------------
class Admin::ProvidersController < Admin::ApplicationController
  include ActiveModel::MassAssignmentSecurity
    
  before_filter "set_current_tab('admin/providers')", :only => [ :index, :show ]

  load_resource

  # GET /providers
  #----------------------------------------------------------------------------
  def index
    @providers = @providers.unscoped.paginate(:page => params[:page])
  end

  # GET /providers/1
  #----------------------------------------------------------------------------
  def show
    respond_with(@provider)
  end

  # GET /providers/new
  #----------------------------------------------------------------------------
  def new      
    if params[:related]
      model, id = params[:related].split('_')
      if related = model.classify.constantize.my.find_by_id(id)
        instance_variable_set("@#{model}", related)
      else
        respond_to_related_not_found(model) and return
      end
    end
      
    respond_with(@provider)
  end

  # GET /providers/1/edit
  #----------------------------------------------------------------------------
  def edit
    puts "Metodo: edit" 
    respond_with(@provider)
  end

  def assign_attributes(values, options = {})
    sanitize_for_mass_assignment(values, options[:as]).each do |k, v|
      send("#{k}=", v)
    end
  end

  # POST /providers
  #----------------------------------------------------------------------------
  def create
    @provider.update_attributes(params[:provider])

    respond_with(@provider)
  end

  # PUT /providers/1
  #----------------------------------------------------------------------------
  def update
    @provider.update_attributes(params[:provider])

    respond_with(@provider)
  end

  # DELETE /providers/1
  #----------------------------------------------------------------------------
  def destroy
    @provider.destroy

    respond_with(@provider)
  end

private

  #----------------------------------------------------------------------------
  alias :get_providers :get_list_of_records
  
end
