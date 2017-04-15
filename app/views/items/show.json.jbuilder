#json.partial! "items/item", item: @item
json.extract! @item, :id, :label, :picture, :attachments, :created_at, :updated_at