# Copyright (c) 2008-2013 Michael Dvorkin and contributors.
#
# Fat Free CRM is freely distributable under the terms of MIT license.
# See MIT-LICENSE file or http://www.opensource.org/licenses/mit-license.php
#------------------------------------------------------------------------------
class CapacitiesController < EntitiesController
  before_filter :get_data_for_sidebar, :only => :index
  autocomplete :account, :name, :full => true

  # GET /capacities
  #----------------------------------------------------------------------------
  def index
    @capacities = get_capacities(:page => params[:page])

    respond_with @capacities do |format|
       format.xls { render :layout => 'header' }
       format.csv { render :csv => @capacities }
    end
  end

  # GET /capacities/1
  # AJAX /capacities/1
  #----------------------------------------------------------------------------
  def show
    @comment = Comment.new
    @timeline = timeline(@capacity)
    respond_with(@capacity)
  end

  # GET /capacities/new
  #----------------------------------------------------------------------------
  def new
    @capacity.attributes = {:user => current_user, :access => Setting.default_access}
    # , :assigned_to => nil
    #get_campaigns

    if params[:related]
      model, id = params[:related].split('_')
      if related = model.classify.constantize.my.find_by_id(id)
        instance_variable_set("@#{model}", related)
      else
        respond_to_related_not_found(model) and return
      end
    end

    respond_with(@capacity)
  end

  # GET /capacities/1/edit                                                      AJAX
  #----------------------------------------------------------------------------
  def edit
    #get_campaigns

    if params[:previous].to_s =~ /(\d+)\z/
      @previous = Capacity.my.find_by_id($1) || $1.to_i
    end

    respond_with(@capacity)
  end

  # POST /capacities
  #----------------------------------------------------------------------------
  def create
    #get_campaigns
    @comment_body = params[:comment_body]

    respond_with(@capacity) do |format|
      if @capacity.save_with_permissions(params)        
        if called_from_index_page?
          @capacities = get_capacities
          get_data_for_sidebar
#        else
#          get_data_for_sidebar(:campaign)
        end
      end
    end
  end

  # PUT /capacities/1
  #----------------------------------------------------------------------------
  def update
    respond_with(@capacity) do |format|
      # Must set access before user_ids, because user_ids= method depends on access value.
      @capacity.access = params[:capacity][:access] if params[:capacity][:access]
      if @capacity.update_with_capacity_counters(params[:capacity])
        update_sidebar
#      else
#        @campaigns = Campaign.my.order('name')
      end
    end
  end

  # DELETE /capacities/1
  #----------------------------------------------------------------------------
  def destroy
    @capacity.destroy

    respond_with(@capacity) do |format|
      format.html { respond_to_destroy(:html) }
      format.js   { respond_to_destroy(:ajax) }
    end
  end

  # GET /capacities/1/convert
  #----------------------------------------------------------------------------
  def convert    

    if params[:previous].to_s =~ /(\d+)\z/
      @previous = Capacity.my.find_by_id($1) || $1.to_i
    end

    respond_with(@capacity)
  end  

  # PUT /capacities/1/reject
  #----------------------------------------------------------------------------
  def reject
    @capacity.reject
    update_sidebar

    respond_with(@capacity) do |format|
      format.html { flash[:notice] = t(:msg_asset_rejected, @capacity.full_name); redirect_to capacities_path }
    end
  end

  # PUT /capacities/1/attach
  #----------------------------------------------------------------------------
  # Handled by EntitiesController :attach

  # POST /capacities/1/discard
  #----------------------------------------------------------------------------
  # Handled by EntitiesController :discard

  # POST /capacities/auto_complete/query                                        AJAX
  #----------------------------------------------------------------------------
  # Handled by ApplicationController :auto_complete


  # POST /capacities/redraw                                                     AJAX
  #----------------------------------------------------------------------------
  def redraw
    current_user.pref[:capacities_per_page] = params[:per_page] if params[:per_page]

    # Sorting and naming only: set the same option for Contacts if the hasn't been set yet.
    if params[:sort_by]
      current_user.pref[:capacities_sort_by] = Capacity::sort_by_map[params[:sort_by]]
      if Contact::sort_by_fields.include?(params[:sort_by])
        current_user.pref[:contacts_sort_by] ||= Contact::sort_by_map[params[:sort_by]]
      end
    end
    if params[:naming]
      current_user.pref[:capacities_naming] = params[:naming]
      current_user.pref[:contacts_naming] ||= params[:naming]
    end

    @capacities = get_capacities(:page => 1, :per_page => params[:per_page]) # Start one the first page.
    set_options # Refresh options
    
    respond_with(@capacities) do |format|
      format.js { render :index }
    end
  end

  # POST /capacities/filter                                                     AJAX
  #----------------------------------------------------------------------------
  def filter
    session[:capacities_filter] = params[:status]
    @capacities = get_capacities(:page => 1, :per_page => params[:per_page]) # Start one the first page.
    
    respond_with(@capacities) do |format|
      format.js { render :index }
    end
  end

private

  #----------------------------------------------------------------------------
  alias :get_capacities :get_list_of_records

  #----------------------------------------------------------------------------
#  def get_campaigns
#    @campaigns = Campaign.my.order('name')
#  end

  def set_options
    super
    @naming = (current_user.pref[:capacities_naming] || Capacity.first_name_position) unless params[:cancel].true?
  end

  #----------------------------------------------------------------------------
  def respond_to_destroy(method)
    if method == :ajax
      if called_from_index_page?                  # Called from capacities index.
        get_data_for_sidebar                      # Get data for the sidebar.
        @capacities = get_capacities                        # Get capacities for current page.
        if @capacities.blank?                          # If no capacity on this page then try the previous one.
          @capacities = get_capacities(:page => current_page - 1) if current_page > 1
          render :index and return                # And reload the whole list even if it's empty.
        end
      else                                        # Called from related asset.
        self.current_page = 1                     # Reset current page to 1 to make sure it stays valid.
#        @campaign = @capacity.campaign                # Reload capacity's campaign if any.
      end                                         # Render destroy.js.rjs
    else # :html destroy
      self.current_page = 1
      flash[:notice] = t(:msg_asset_deleted, @capacity.full_name)
      redirect_to capacities_path
    end
  end

  #----------------------------------------------------------------------------
  def get_data_for_sidebar(related = false)
    if related
      instance_variable_set("@#{related}", @capacity.send(related)) if called_from_landing_page?(related.to_s.pluralize)    
    end
  end

  #----------------------------------------------------------------------------
  def update_sidebar
    if called_from_index_page?
      get_data_for_sidebar
#    else
#      get_data_for_sidebar(:campaign)
    end
  end
end
