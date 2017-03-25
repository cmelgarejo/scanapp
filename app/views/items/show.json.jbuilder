#json.partial! "items/item", item: @item
json.extract! @item, :id, :label, :picture, :documents, :created_at, :updated_at