class CreateItemService
  def call(company_id, label, template = false)
    Item.find_or_create_by!(company_id: company_id, label: label, template: template)
  end
end