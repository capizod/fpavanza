# Copyright (c) 2008-2013 Michael Dvorkin and contributors.
#
# Fat Free CRM is freely distributable under the terms of MIT license.
# See MIT-LICENSE file or http://www.opensource.org/licenses/mit-license.php
#------------------------------------------------------------------------------
class ProviderViewsController < ApplicationController
  before_filter :require_user, :except => [ :toggle, :timezone ]
  before_filter :set_current_tab, :only => :index
  before_filter "hook(:home_before_filter, self, :amazing => true)"

  #----------------------------------------------------------------------------
  def index    
    hook(:provider_view_controller, self, :params => "it works!")    
    #@my_accounts = Account.prospect_accounts(current_user).by_name    
    #@my_accounts = Account.lonely
    @my_providers = get_provider_views(:page => params[:page], :per_page => params[:per_page])    
    @provider_views = @my_providers

    respond_with @provider_views do |format|
      format.xls { render :layout => 'header' }
      format.csv { render :csv => @provider_views }
    end
  end

  # GET /accounts/new
  #----------------------------------------------------------------------------
  def new
    @provider_view = Account.new;

    if params[:related]
      model, id = params[:related].split('_')
      instance_variable_set("@#{model}", model.classify.constantize.find(id))
    end

    respond_with(@provider_view)
  end

  # GET /home/options                                                      AJAX
  #----------------------------------------------------------------------------
  def options
    
  end

  # POST /home/redraw                                                      AJAX
  #----------------------------------------------------------------------------
  def redraw
    
    render :index
  end

  # GET /home/toggle                                                       AJAX
  #----------------------------------------------------------------------------
  def toggle
    if session[params[:id].to_sym]
      session.delete(params[:id].to_sym)
    else
      session[params[:id].to_sym] = true
    end
    render :nothing => true
  end

  # GET /home/timeline                                                     AJAX
  #----------------------------------------------------------------------------
  def timeline
    unless params[:type].empty?
      model = params[:type].camelize.constantize
      item = model.find(params[:id])
      item.update_attribute(:state, params[:state])
    else
      comments, emails = params[:id].split("+")
      Comment.update_all("state = '#{params[:state]}'", "id IN (#{comments})") unless comments.blank?
      Email.update_all("state = '#{params[:state]}'", "id IN (#{emails})") unless emails.blank?
    end

    render :nothing => true
  end

  # GET /home/timezone                                                     AJAX
  #----------------------------------------------------------------------------
  def timezone
    #
    # (new Date()).getTimezoneOffset() in JavaScript returns (UTC - localtime) in
    # minutes, while ActiveSupport::TimeZone expects (localtime - UTC) in seconds.
    #
    if params[:offset]
      session[:timezone_offset] = params[:offset].to_i * -60
      ActiveSupport::TimeZone[session[:timezone_offset]]
    end
    render :nothing => true
  end

  private    
  
  #----------------------------------------------------------------------------
  def get_provider_views(options = {})
    self.current_page  = options[:page]                        if options[:page] 
    wants = request.format
    
    data = Account.providerview
    @search_results_count = Account.providerview  

    # Pagination is disabled for xls and csv requests
    unless (wants.xls? || wants.csv?)
      per_page = if options[:per_page]
        options[:per_page] == 'all' ? @search_results_count : options[:per_page]
      else
        current_user.pref[:"#{controller_name}_per_page"]
      end
      data = Account.providerview.paginate(:page => current_page, :per_page => per_page)
    end
    
    data
  end

end
