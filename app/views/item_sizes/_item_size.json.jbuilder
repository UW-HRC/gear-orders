json.extract! item_size, :id, :created_at, :updated_at, :name
json.item_id item_size.item.id
json.item_name item_size.item.name
json.item_description item_size.item.description