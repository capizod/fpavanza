# Copyright (c) 2008-2013 Michael Dvorkin and contributors.
#
# Fat Free CRM is freely distributable under the terms of MIT license.
# See MIT-LICENSE file or http://www.opensource.org/licenses/mit-license.php
#------------------------------------------------------------------------------
module AccountsHelper

  # Sidebar checkbox control for filtering accounts by category.
  #----------------------------------------------------------------------------
  def account_category_checkbox(category, count)
    entity_filter_checkbox(:category, category, count)
  end

  # Quick account summary for RSS/ATOM feeds.
  #----------------------------------------------------------------------------
  def account_summary(account)
    [ number_to_currency(account.opportunities.pipeline.map(&:weighted_amount).sum, :precision => 0),
      t(:added_by, :time_ago => time_ago_in_words(account.created_at), :user => account.user_id_full_name),
      t('pluralize.contact', account.contacts.count),
      t('pluralize.opportunity', account.opportunities.count),
      t('pluralize.comment', account.comments.count)
    ].join(', ')
  end

  def account_select(options = {})
      # Generates a select list with the first 25 accounts,
      # and prepends the currently selected account, if available
      options[:selected] = (@account && @account.id) || 0
      accounts = ([@account] + Account.my.order(:name).limit(25)).compact.uniq
      collection_select :account, :id, accounts, :id, :name, options,
                        {:"data-placeholder" => t(:select_an_account),
                         :style => "width:330px; display:none;" }
  end

  # Select an existing account or create a new one.
  #----------------------------------------------------------------------------
  def account_select_or_create(form, &block)
    options = {}
    yield options if block_given?

    content_tag(:div, :class => 'label') do
      t(:account).html_safe +

      content_tag(:span, :id => 'account_create_title') do
        "(#{t :create_new} #{t :or} <a href='#' onclick='crm.select_account(1); return false;'>#{t :select_existing}</a>):".html_safe
      end.html_safe +

      content_tag(:span, :id => 'account_select_title') do
        "(<a href='#' onclick='crm.create_account(1); return false;'>#{t :create_new}</a> #{t :or} #{t :select_existing}):".html_safe
      end.html_safe +

      content_tag(:span, ':', :id => 'account_disabled_title').html_safe
    end.html_safe +

    account_select(options).html_safe +
    form.text_field(:name, :style => 'width:324px; display:none;')
  end

  # Output account url for a given contact
  # - a helper so it is easy to override in plugins that allow for several accounts
  #----------------------------------------------------------------------------
  def account_with_url_for(contact)
    contact.account ? link_to(h(contact.account.name), account_path(contact.account)) : ""
  end

  # Output account with title and department
  # - a helper so it is easy to override in plugins that allow for several accounts
  #----------------------------------------------------------------------------
  def account_with_title_and_department(contact)
    text = if !contact.title.blank? && contact.account
        # works_at: "{{h(job_title)}} at {{h(company)}}"
        content_tag :div, t(:works_at, :job_title => h(contact.title), :company => account_with_url_for(contact)).html_safe
      elsif !contact.title.blank?
        content_tag :div, h(contact.title)
      elsif contact.account
        content_tag :div, account_with_url_for(contact)
      else
        ""
      end
    text << t(:department_small, h(contact.department)) unless contact.department.blank?
    text
  end

  # "title, department at Account name" used in index_brief and index_long
  # - a helper so it is easy to override in plugins that allow for several accounts
  #----------------------------------------------------------------------------
  def brief_account_info(contact)
    text = ""
    title = contact.title
    department = contact.department
    account = contact.account
    account_text = ""    

    text << ""
    text.html_safe
  end

end