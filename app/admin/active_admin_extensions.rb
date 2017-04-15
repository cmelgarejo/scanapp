#class ActiveAdminExtensions
  # This file extends and overrides parts of the ActiveAdmin DSL and internals
  # in order to provide support for automatically displaying and editing images,
  # which in our infrastructure are stored as URLs whose column names end in "img".
  # Since this file will be reloaded frequently in the development environment,
  # all operations done at load time (class_eval's, etc.) MUST be idempotent.

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