# :nodoc:
module ApplicationHelper
  ALERT_TYPES = [:success, :info, :warning, :danger] unless const_defined?(:ALERT_TYPES)

  def bootstrap_flash(options = {})
    flash_messages = []
    flash.each do |type, message|
      # Skip empty messages, e.g. for devise messages set to nothing in a locale file.
      next if message.blank?

      type = type.to_sym
      type = :success if type == :notice
      type = :danger  if type == :alert
      type = :danger  if type == :error
      next unless ALERT_TYPES.include?(type)

      tag_class = options.extract!(:class)[:class]
      tag_options = {
        class: "alert fade in alert-#{type} #{tag_class}"
      }.merge(options)

      close_button = content_tag(:button, raw("&times;"), type: "button", class: "close", "data-dismiss" => "alert")

      Array(message).each do |msg|
        text = content_tag(:div, close_button + msg, tag_options)
        flash_messages << text if msg
      end
    end
    flash_messages.join("\n").html_safe
  end
  
  def left_menu
    left_menu_entries(left_menu_content)
  end

  private

  def selected_locale
    locale = FastGettext.locale
    locale_list.detect {|entry| entry[:locale] == locale}
  end

  def locale_list
    [
      {
        flag: 'us',
        locale: 'en',
        name: 'English (US)',
        alt_name: 'United States'
      },
      {
        flag: 'fr',
        locale: 'fr',
        name: 'Français',
        alt_name: 'France'
      },
      {
        flag: 'es',
        locale: 'es',
        name: 'Español',
        alt_name: 'Spanish'
      },
      {
        flag: 'de',
        locale: 'de',
        name: 'Deutsch',
        alt_name: 'German'
      },
      {
        flag: 'jp',
        locale: 'ja',
        name: '日本語',
        alt_name: 'Japan'
      },
      {
        flag: 'cn',
        locale: 'zh',
        name: '中文',
        alt_name: 'China'
      },
      {
        flag: 'it',
        locale: 'it',
        name: 'Italiano',
        alt_name: 'Italy'
      },
      {
        flag: 'pt',
        locale: 'pt',
        name: 'Portugal',
        alt_name: 'Portugal'
      },
      {
        flag: 'ru',
        locale: 'ru',
        name: 'Русский язык',
        alt_name: 'Russia'
      },
      {
        flag: 'kr',
        locale: 'kr',
        name: '한국어',
        alt_name: 'Korea'
      },
    ]
  end

  def left_menu_entries(entries = [])
    output = ''
    entries.each do |entry|
      children_selected = entry[:children] &&
        entry[:children].any? {|child| current_page?(child[:href]) }
      entry_selected =  current_page?(entry[:href])
      li_class =
      case
        when children_selected
          'open'
        when entry_selected
          'active'
      end
      output +=
        content_tag(:li, class: li_class) do
          subentry = ''
          subentry +=
            link_to entry[:href], title: entry[:title], class: entry[:class], target: entry[:target] do
              link_text = ''
              link_text += entry[:content].html_safe
              if entry[:children]
                if children_selected
                  link_text += '<b class="collapse-sign"><em class="fa fa-minus-square-o"></em></b>'
                else
                  link_text += '<b class="collapse-sign"><em class="fa fa-plus-square-o"></em></b>'
                end
              end

              link_text.html_safe
            end
          if entry[:children]
            if children_selected
              ul_style = 'display: block'
            else
              ul_style = ''
            end
            subentry +=
              "<ul style='#{ul_style}'>" +
                left_menu_entries(entry[:children]) +
                "</ul>"
          end

          subentry.html_safe
        end
    end
    output.html_safe
  end

  def left_menu_content
    [
      {
        href: root_path,
        title: _('blank'),
        content: "<i class='fa fa-lg fa-fw fa-home'></i> <span class='menu-item-parent'>" + _('Blank') + "</span>",
      },
      {
        href: '#',
        title: _('Users'),
        content: "<i class='fa fa-lg fa-fw fa-users'></i> <span class='menu-item-parent'>" + _('Users') + "</span>",
        children: [
          {
            href: new_member_path,
            title: _('Add new user'),
            content: "<span class='menu-item-parent'>" + _('Add new user') + "</span>"
          },
          {
            href: root_path,
            title: _('Dashboard'),
            content: "<span class='menu-item-parent'>" + _('Social Wall') + "</span>"
          },
        ]
      },
    ]
  end

end
