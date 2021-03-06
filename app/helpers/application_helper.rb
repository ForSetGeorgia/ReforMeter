# General helpers for application views
module ApplicationHelper
  def page_title(page_title)
    content_for(:page_title) { page_title.html_safe }
  end

  def page_description(page_description)
    content_for(:page_description) { page_description.html_safe }
  end

  def current_url
    "#{request.protocol}#{request.host_with_port}#{request.fullpath}"
  end

  def full_url(path)
    "#{request.protocol}#{request.host_with_port}#{path}"
  end

  # apply the strip_tags helper and also convert nbsp to a ' '
  def strip_tags_nbsp(text)
    if text.present?
      strip_tags(text.gsub('&nbsp;', ' '))
    end
  end

  # from http://www.kensodev.com/2012/03/06/better-simple_format-for-rails-3-x-projects/
  # same as simple_format except it does not wrap all text in p tags
  def simple_format_no_tags(text, _html_options = {}, options = {})
    text = '' if text.nil?
    text = smart_truncate(text, options[:truncate]) if options[:truncate].present?
    text = sanitize(text) unless options[:sanitize] == false
    text = text.to_str
    text.gsub!(/\r\n?/, "\n")                    # \r\n and \r -> \n
    #   text.gsub!(/([^\n]\n)(?=[^\n])/, '\1<br />') # 1 newline   -> br
    text.html_safe
  end

  def change_icons(args = {})
    icon_class = 'changeIcon js-act-as-change-icon'
    icon_class += " #{args[:mod_class]}" if args[:mod_class].present?

    return {
      '-1': ActionController::Base.helpers.inline_svg('arrow_down.svg', title: I18n.t('shared.change_status.down'), class: icon_class),
      '0': ActionController::Base.helpers.inline_svg('arrow_flat.svg', title: I18n.t('shared.change_status.flat'), class: icon_class),
      '1': ActionController::Base.helpers.inline_svg('arrow_up.svg', title: I18n.t('shared.change_status.up'), class: icon_class)
    }
  end

  # value = -1 -> down arrow
  # value =  0 -> flat arrow
  # value =  1 -> up arrow
  def generate_change_icon(change_value, args = {})
    change_icons(args)[change_value.to_s.to_sym]
  end

  def nav_link_select_class_if_path(paths)
    paths.each do |path|
      if ((path[:controller] == params[:controller]) && (path[:action] == params[:action]))
        return ' mod-current-page'
      end
    end

    return ''
  end

  # format the true/false value into yes/no with box
  def format_boolean_flag(flag, small=false)
    css_small = small == true ? 'boolean-flag-xs' : ''
    if flag == true
      return "<div class='boolean-flag boolean-flag-true #{css_small}'>#{t('shared.common.yes')}</div>".html_safe
    else
      return "<div class='boolean-flag boolean-flag-false #{css_small}'>#{t('shared.common.no')}</div>".html_safe
    end
  end


  # sort the locales so the default locale is first and then the rest are alpha
  def sort_locales(locales)
    if locales.present?
      # sort
      locales.sort!

      # move default locale to first position
      default = locales.index{|x| x == I18n.default_locale}
      if default.present? && default > 0
        locales.unshift(locales[default])
        locales.delete_at(default+1)
      end
    end
    return locales
  end

  def random_string
    ('a'..'z').to_a.shuffle[0,8].join
  end

end
