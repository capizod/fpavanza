module ProductsHelper
  # Product summary for RSS/ATOM feeds.
  #----------------------------------------------------------------------------
  def product_summary(product)
    summary = [""]    
    summary << ProductType.find(product.product_type_id).description    
    summary << "#{t :start_date}: #{product.starts_on}" unless product.starts_on.blank?
    summary << "#{t :end_date}: #{product.ends_on}" unless product.ends_on.blank?
    summary << "#{t :provider_type}: #{ProviderType.find(product.provider_type_id).description}" unless product.provider_type_id.blank?              
    summary.join(' - ')
  end
  
  # Product summary for RSS/ATOM feeds.
  #----------------------------------------------------------------------------
#  def product_summary(product)
#    summary = [""]
#    summary << product.name.titleize if product.name?
#    summary << contact.department if contact.department?
#    if contact.account && contact.account.name?
#      summary.last << " #{t(:at)} #{contact.account.name}"
 #   end
 #   summary << contact.email if contact.email.present?
 #   summary << "#{t(:phone_small)}: #{contact.phone}" if contact.phone.present?
 #   summary << "#{t(:mobile_small)}: #{contact.mobile}" if contact.mobile.present?
 #   summary.join(', ')
 # end
  
  # User summary info for RSS/ATOM feeds.
  #----------------------------------------------------------------------------
#  def user_summary(user)
#    summary = []
#    title_and_company = user.title.blank? ? '' : h(user.title)
#    title_and_company << " #{t(:at)} #{user.company}" unless user.company.blank?
#    summary << title_and_company unless title_and_company.blank?
#    summary << t('pluralize.login', user.login_count) if user.last_request_at && user.login_count > 0
#    summary << user.email
#    summary << "#{t :phone_small}: #{user.phone}" unless user.phone.blank?
#    summary << "#{t :mobile_small}: #{user.mobile}" unless user.mobile.blank?
#    summary << if !user.suspended?
#      t(:user_since, l(user.created_at.to_date, :format => :mmddyy))
#    elsif user.awaits_approval?
#      t(:user_signed_up_on, l(user.created_at, :format => :mmddhhss))
#   else
#      t(:user_suspended_on, l(user.created_at.to_date, :format => :mmddyy))
#    end
#    summary << if user.awaits_approval?
#      t(:user_signed_up)
#    elsif user.suspended?
#      t(:user_suspended)
#    elsif user.admin?
#      t(:user_admin)
#    else
#      t(:user_active)
#    end
#    summary.join(', ')
#  end
end
