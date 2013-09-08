# Copyright (c) 2008-2013 Michael Dvorkin and contributors.
#
# Fat Free CRM is freely distributable under the terms of MIT license.
# See MIT-LICENSE file or http://www.opensource.org/licenses/mit-license.php
#------------------------------------------------------------------------------
class ProductsController < EntitiesController
  before_filter :get_accounts, :only => [ :new, :create, :edit, :update ]

  @exists_acc_params = false;

  # GET /products
  #----------------------------------------------------------------------------
  def index
    @products = get_products(:page => params[:page], :per_page => params[:per_page])

    respond_with @products do |format|
      format.xls { render :layout => 'header' }
      format.csv { render :csv => @products }
    end
  end

  # GET /products/1
  # AJAX /products/1
  #----------------------------------------------------------------------------
  def show
    @stage = Setting.unroll(:opportunity_stage)
    @comment = Comment.new
    @timeline = timeline(@product)
    respond_with(@product)
  end

  def exists_account_parameters
    @exists_acc_params = false;  
    if (params[:account] != nil)
      if params[:account][:id] != ""
        @exists_acc_params = true;
      end
    end
  end   

  # GET /products/new
  #----------------------------------------------------------------------------
  def new
    @product.attributes = {:user => current_user, :access => Setting.default_access, :assigned_to => nil}
    exists_account_parameters()
    if (@exists_acc_params) 
      @account << Account.find(params[:account][:id]) 
    else
      @account = Account.new(:user => current_user)
    end    

    if params[:related]
      model, id = params[:related].split('_')
      if related = model.classify.constantize.my.find_by_id(id)
        instance_variable_set("@#{model}", related)
      else
        respond_to_related_not_found(model) and return
      end
    end

    respond_with(@product)
  end

  # GET /products/1/edit                                                   AJAX
  #----------------------------------------------------------------------------
  def edit
    exists_account_parameters()
    if (@exists_acc_params) 
      @account << Account.find(params[:account][:id]) 
    else
      @account = Account.new(:user => current_user)
    end
    
    if params[:previous].to_s =~ /(\d+)\z/
      @previous = Product.my.find_by_id($1) || $1.to_i
    end

    respond_with(@product)
  end

  # POST /products
  #----------------------------------------------------------------------------
  def create    
    respond_with(@product) do |format|     
      if @product.save_with_account_and_permissions(params)        
        @products = get_products if called_from_index_page?
      else
        unless params[:account][:id].blank?
          @account = Account.find(params[:account][:id])
        else
          if request.referer =~ /\/accounts\/(.+)$/
            @account = Account.find($1) # related account
          else
            @account = Account.new(:user => current_user)
          end
        end
#        @opportunity = Opportunity.my.find(params[:opportunity]) unless params[:opportunity].blank?
      end
    end
  end

  # PUT /products/1
  #----------------------------------------------------------------------------
  def update
    respond_with(@product) do |format|
      unless @product.update_with_account_and_permissions(params)
        unless params[:account][:id].blank?
          @account = Account.find(params[:account][:id])
        else
          if request.referer =~ /\/accounts\/(.+)$/
            @account = Account.find($1) # related account
          else
            @account_prod = AccountProduct.fin(self.id)  
            @account = Account.find(@account_prod.account_id)           
          end
        end
      end
    end
  end

  # DELETE /products/1
  #----------------------------------------------------------------------------
  def destroy
    @product.destroy

    respond_with(@product) do |format|
      format.html { respond_to_destroy(:html) }
      format.js   { respond_to_destroy(:ajax) }
    end
  end

  # PUT /products/1/attach
  #----------------------------------------------------------------------------
  # Handled by EntitiesController :attach

  # POST /products/1/discard
  #----------------------------------------------------------------------------
  # Handled by EntitiesController :discard

  # POST /products/auto_complete/query                                     AJAX
  #----------------------------------------------------------------------------
  # Handled by ApplicationController :auto_complete

  # POST /products/redraw                                                  AJAX
  #----------------------------------------------------------------------------
  def redraw
    current_user.pref[:products_per_page] = params[:per_page] if params[:per_page]

    # Sorting and naming only: set the same option for Leads if the hasn't been set yet.
    if params[:sort_by]
      current_user.pref[:products_sort_by] = Product::sort_by_map[params[:sort_by]]
      if Lead::sort_by_fields.include?(params[:sort_by])
        current_user.pref[:leads_sort_by] ||= Lead::sort_by_map[params[:sort_by]]
      end
    end
    if params[:naming]
      current_user.pref[:products_naming] = params[:naming]
      current_user.pref[:leads_naming] ||= params[:naming]
    end

    @products = get_products(:page => 1, :per_page => params[:per_page]) # Start on the first page.
    set_options # Refresh options
    
    respond_with(@products) do |format|
      format.js { render :index }
    end
  end

  private
  #----------------------------------------------------------------------------
  alias :get_products :get_list_of_records

  #----------------------------------------------------------------------------
  def get_accounts
    @accounts = Account.my.order('name')
  end

  def set_options
    super
    @naming = (current_user.pref[:products_naming]   || Product.name_position) unless params[:cancel].true?
  end

  #----------------------------------------------------------------------------
  def respond_to_destroy(method)  
    if method == :ajax 
      if called_from_index_page?
        @products = get_products(:page => params[:page], :per_page => params[:per_page])
        if @products.blank?
          flash[:notice] = t(:msg_asset_non_blank, @products.name)
          if current_page > 1
            @products = get_products(:page => current_page - 1, :per_page => params[:per_page])
          else
            @products = get_products(:page => 1, :per_page => params[:per_page])  
          end   
          render :index and return
        end
      else
        self.current_page = 1  
      end
    else
      self.current_page = 1
      flash[:notice] = t(:msg_asset_deleted, @product.name)
      redirect_to products_path
    end
  end
end
