class CreateItemService
  def call(company_id, label, properties = nil, is_template = false, template = nil, parents = [])
    p "TEMPLATE: #{template}"
    properties = template.properties if !is_template && template && template.is_template
    item = Item.find_or_create_by!(company_id: company_id, label: label)
    item.update(qrcode: RQRCode::QRCode.new(item.id, size: 5).as_ansi, properties: properties, is_template: is_template,
                template: template, parents: parents)
    item #return Item
  end
end