class CreateItemService
  def call(company_id, label, properties = nil, is_template = false, template = nil, parents = [])
    p "TEMPLATE: #{template.id} - #{template.label}" if template
    properties = template.properties if !is_template && template && template.is_template
    item = Item.find_or_create_by!(company: Company.find_by_id(company_id), label: label)
    item.update(qrcode: RQRCode::QRCode.new(item.id, size: 6).to_s, properties: properties, is_template: is_template,
                template: template, parents: parents)
    item.update(picture: DocumentUploader.new.store!(RQRCode::QRCode.new(item.id, size: 5).as_png))
    puts "Created Item: #{item.id} - #{item.label} - QR CODE: \n#{item.qrcode}"
    item #return Item
  end
end