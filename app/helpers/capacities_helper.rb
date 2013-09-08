# Copyright (c) 2008-2013 Michael Dvorkin and contributors.
#
# Fat Free CRM is freely distributable under the terms of MIT license.
# See MIT-LICENSE file or http://www.opensource.org/licenses/mit-license.php
#------------------------------------------------------------------------------
module CapacitiesHelper
  
  #----------------------------------------------------------------------------
  def link_to_reject(capacity)
    link_to(t(:reject) + "!", reject_capacity_path(capacity), :method => :put, :remote => true)
  end

  #----------------------------------------------------------------------------
  def confirm_reject(capacity)
    question = %(<span class="warn">#{t(:reject_capacity_confirm)}</span>).html_safe
    yes = link_to(t(:yes_button), reject_capacity_path(capacity), :method => :put)
    no = link_to_function(t(:no_button), "$('menu').update($('confirm').innerHTML)")
    update_page do |page|
      page << "$('confirm').update($('menu').innerHTML)"
      page[:menu].replace_html "#{question} #{yes} : #{no}"
    end
  end

  # Sidebar checkbox control for filtering capacities by status.
  #----------------------------------------------------------------------------
  def capacity_status_checkbox(status, count)
    entity_filter_checkbox(:status, status, count)
  end

  # Returns default permissions intro for capacities
  #----------------------------------------------------------------------------
  def get_capacity_default_permissions_intro(access)
    case access
      when "Private" then t(:capacity_permissions_intro_private, t(:opportunity_small))
      when "Public" then t(:capacity_permissions_intro_public, t(:opportunity_small))
      when "Shared" then t(:capacity_permissions_intro_shared, t(:opportunity_small))
    end
  end

  # Returns default permissions intro for capacities.
  #----------------------------------------------------------------------------
  def get_capacity_default_permissions_intro(access)
    case access
      when "Private" then t(:capacity_permissions_intro_private, t(:opportunity_small))
      when "Public"  then t(:capacity_permissions_intro_public,  t(:opportunity_small))
      when "Shared"  then t(:capacity_permissions_intro_shared,  t(:opportunity_small))
    end
  end

  # Do not offer :converted status choice if we are creating a new capacity or
  # editing existing capacity that hasn't been converted before.
  #----------------------------------------------------------------------------
  def capacity_status_codes_for(capacity)
    if capacity.status != "converted" && (capacity.new_record? || capacity.contact.nil?)
      Setting.unroll(:capacity_status).delete_if { |status| status.last == :converted }
    else
      Setting.unroll(:capacity_status)
    end
  end

  # capacity summary for RSS/ATOM feed.
  #----------------------------------------------------------------------------
  def capacity_summary(capacity)
    summary = []
    summary << "#{t(:emploee_id)} #{capacity.capacity_emploee_id}" if capacity.capacity_emploee_id.present?
    summary << "#{capacity.capacity_tc.name}" if capacity.capacity_tc.present?
    summary << "#{capacity.city.name}" if capacity.capacity_te.present?
    summary << "#{capacity.region.name}" if capacity.region.present?
    summary << "#{capacity.city.name}" if capacity.city.present?    
    summary << "#{capacity.city.name}" if capacity.capacity_te.present?
    summary.join(' - ')
  end
end

