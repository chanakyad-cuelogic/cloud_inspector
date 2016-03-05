json.array!(@security_groups) do |security_group|
  json.extract! security_group, :id, :data
  json.url security_group_url(security_group, format: :json)
end
