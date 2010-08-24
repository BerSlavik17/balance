Factory.define :setting do |f|
  f.sequence(:key) { |n| "key number #{n}" }
  f.value "MyString"
end

