Factory.define :item do |f|
  f.date Date.today
  f.summa '2+2'
  f.association :category
end

