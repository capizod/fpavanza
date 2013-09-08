#------------------------------------------------------------------------------
class Admin::BranchesController < Admin::ApplicationController
  include ActiveModel::MassAssignmentSecurity
    
  before_filter "set_current_tab('admin/branches')", :only => [ :index, :show ]

  load_resource

  # GET /branches
  #----------------------------------------------------------------------------
  def index
    @branches = @branches.unscoped.paginate(:page => params[:page])
  end

  # GET /branches/1
  #----------------------------------------------------------------------------
  def show
    respond_with(@branch)
  end

  # GET /branches/new
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
      
    respond_with(@branch)
  end

  # GET /branches/1/edit
  #----------------------------------------------------------------------------
  def edit
    puts "Metodo: edit" 
    respond_with(@branch)
  end

  def assign_attributes(values, options = {})
    sanitize_for_mass_assignment(values, options[:as]).each do |k, v|
      send("#{k}=", v)
    end
  end

  # POST /branches
  #----------------------------------------------------------------------------
  def create
    @branch.update_attributes(params[:branch])

    respond_with(@branch)
  end

  # PUT /branches/1
  #----------------------------------------------------------------------------
  def update
    @branch.update_attributes(params[:branch])

    respond_with(@branch)
  end

  # DELETE /branches/1
  #----------------------------------------------------------------------------
  def destroy
    @branch.destroy

    respond_with(@branch)
  end
  
private

  #----------------------------------------------------------------------------
  alias :get_branches :get_list_of_records
  
end
