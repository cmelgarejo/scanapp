#class ActiveAdminExtensions
# This file extends and overrides parts of the ActiveAdmin DSL and internals
# in order to provide support for automatically displaying and editing images,
# which in our infrastructure are stored as URLs whose column names end in "img".
# Since this file will be reloaded frequently in the development environment,
# all operations done at load time (class_eval's, etc.) MUST be idempotent.

module ActiveAdminAddons
  class CarrierwaveAttachmentBuilder < CustomBuilder

    ActiveAdmin::Views::Pages::Show.class_eval do
      KNOWN_EXTENSIONS = %w{
        3gp 7z ace ai aif aiff amr asf asx bat bin bmp bup cab cbr cda cdl cdr chm
        dat divx dll dmg doc docx dss dvf dwg eml eps exe fla flv gif gz hqx htm html
        ifo indd iso jar jpeg jpg lnk log m4a m4b m4p m4v mcd mdb mid mov mp2 mp3 mp4
        mpeg mpg msi mswmm ogg pdf png pps ppt pptx ps psd pst ptb pub qbb qbw qxd ram
        rar rm rmvb rtf sea ses sit sitx ss swf tgz thm tif tmp torrent ttf txt
        vcd vob wav wma wmv wps xls xlsx xpi zip
      } if KNOWN_EXTENSIONS == nil

      def icon_for_filename(filename)
        for_ext File.extname(filename.to_s)
      end

      def for_ext(file_extension)
        ext = file_extension.start_with?('.') ? file_extension[1..-1] : file_extension
        ext.downcase!
        ext = 'unknown' unless KNOWN_EXTENSIONS.include?(ext)
        "fileicons/file_extension_#{ext}.png"
      end

      def build_label(filename, label_text = I18n.t('Download'))
        icon = icon_for_filename(filename)
        style = {width: '20', height: '20', style: 'margin-right: 5px; vertical-align: middle;'}
        icon_img = image_tag(icon, style)
        text = label_text

        content_tag(:span) do
          concat(icon_img)
          safe_concat(text)
        end
      end
    end

    ActiveAdmin::Views::ActiveAdminForm.class_eval do
      def icon_for_filename(filename)
        for_ext File.extname(filename.to_s)
      end

      def for_ext(file_extension)
        ext = file_extension.start_with?('.') ? file_extension[1..-1] : file_extension
        ext.downcase!
        ext = 'unknown' unless KNOWN_EXTENSIONS.include?(ext)
        "fileicons/file_extension_#{ext}.png"
      end

      def build_hint_file(filename, link_to, label_text = I18n.t('Download'))
        icon = icon_for_filename(filename)
        style = {width: '20', height: '20', style: 'margin-right: 5px; vertical-align: middle;'}
        icon_img = image_tag(icon, style)
        text = "#{label_text} - #{filename}"

        #<p class="inline-hints">
        content_tag(:p, class: 'inline-hints') do
          content_tag(:a, href: link_to) do
            content_tag(:span) do
              concat(icon_img)
              safe_concat(text)
            end
          end
        end
      end
    end
  end
end

ActiveAdmin::Views::PaginatedCollection.class_eval do
  def build_pagination_with_formats(options)
    div :id => 'index_footer' do
      build_pagination
      div(page_entries_info(options).html_safe, class: 'pagination_information')
      build_download_format_links([:csv, :json]) unless !@download_links
    end
  end
end

#   ActiveAdmin::Views::TableFor.class_eval do
#
#     def img_column(col_sym=:img, title='Image')
#       column title, sortable: false do |obj|
#         url = obj.send(col_sym)
#         link_to(filepicker_image_tag(url, width: 100, height: 100), url)
#       end
#     end
#   end
#
# # You can also subclass this and do `index as: MyIndexAsTableSubclass` to get the same functionality
#   ActiveAdmin::Views::IndexAsTable.class_eval do
#     def default_table
#       proc do
#         selectable_column
#         id_column
#         resource_class.content_columns.each do |col|
#           if col.name.ends_with? 'img'
#             img_column col.name.to_sym
#           else
#             column col.name.to_sym
#           end
#         end
#         default_actions
#       end
#     end
#   end
#
#   ActiveAdmin::Views::AttributesTable.class_eval do
#     def content_for(record, attr)
#       previous = current_arbre_element.to_s
#
#       if attr.to_s.ends_with? "img"
#         value = find_attr_value(record, attr)
#         value = link_to(filepicker_image_tag(value, width: 200, height: 200), value)
#       else
#         value = pretty_format find_attr_value(record, attr)
#       end
#
#       value.blank? && previous == current_arbre_element.to_s ? empty_value : value
#     end
#   end
#
#   class FilepickerForActiveAdminInput
#     include Formtastic::Inputs::Base
#     def to_html
#       input_wrapping do
#         label_html <<
#             builder.filepicker_field(method, input_html_options)
#       end
#     end
#   end
#
#   ActiveAdmin::FormBuilder.class_eval do
#
#     protected
#
#     def default_input_type(method, options = {})
#       if column = column_for(method) and column.type == :string
#         if method.to_s.ends_with? 'img'
#           return :filepicker_for_active_admin
#         end
#       end
#       super
#     end
#
#   end
#end