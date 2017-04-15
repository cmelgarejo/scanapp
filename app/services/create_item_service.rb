class CreateItemService
  def call(company_id, label, extra_properties = nil, is_template = false, template = nil, parents = [])
    p "TEMPLATE: #{template.id} - #{template.label}" if template
    extra_properties = template.extra_properties if !is_template && template && template.is_template
    item = Item.find_or_create_by!(company: Company.find_by_id(company_id), label: label, description: label, extra_properties: extra_properties)
    puts "Created Item: #{item.id} - #{item.label}"
    item #return Item
  end
end