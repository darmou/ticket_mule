Factory.define :time_type do |p|
  p.name 'Trivial'
end

Factory.define :disabled_time_type, :parent => :time_type do |p|
  p.disabled_at Time.now
end