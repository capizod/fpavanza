# Copyright (c) 2008-2013 Michael Dvorkin and contributors.
#
# Fat Free CRM is freely distributable under the terms of MIT license.
# See MIT-LICENSE file or http://www.opensource.org/licenses/mit-license.php
#------------------------------------------------------------------------------
class Admin::ApplicationController < ApplicationController
  before_filter :require_admin_user

  layout "admin/application"
  helper "admin/field_groups"

  # Autocomplete handler for all admin controllers.
  #----------------------------------------------------------------------------
  def auto_complete
    @query = params[:auto_complete_query]
    @auto_complete = klass.text_search(@query).limit(10)
    render :partial => 'auto_complete'
  end

private

  def ransack_search
    @ransack_search ||= load_ransack_search
    @ransack_search.build_sort if @ransack_search.sorts.empty?
    @ransack_search
  end

  # Get list of records for a given model class.
  #----------------------------------------------------------------------------
  def get_list_of_records(options = {})
    options[:query]  ||= params[:query]                        if params[:query]
    self.current_page  = options[:page]                        if options[:page]
    query, tags        = parse_query_and_tags(options[:query])
    self.current_query = query
    advanced_search = params[:q].present?
    wants = request.format

    scope = entities.merge(ransack_search.result(:distinct => true))

    # Get filter from session, unless running an advanced search
    unless advanced_search
      filter = session[:"#{controller_name}_filter"].to_s.split(',')
      scope = scope.state(filter) if filter.present?
    end

    scope = scope.text_search(query)              if query.present?
    scope = scope.tagged_with(tags, :on => :tags) if tags.present?

    # Ignore this order when doing advanced search
    unless advanced_search
      order = current_user.pref[:"#{controller_name}_sort_by"] || klass.sort_by
      scope = scope.order(order)
    end

    @search_results_count = scope.count

    # Pagination is disabled for xls and csv requests
    unless (wants.xls? || wants.csv?)
      per_page = if options[:per_page]
        options[:per_page] == 'all' ? @search_results_count : options[:per_page]
      else
        current_user.pref[:"#{controller_name}_per_page"]
      end
      scope = scope.paginate(:page => current_page, :per_page => per_page)
    end
    
    scope
  end

  #----------------------------------------------------------------------------
  def require_admin_user
    require_user
    if current_user && !current_user.admin?
      flash[:notice] = t(:msg_require_admin)
      redirect_to root_path
    end
  end
end
