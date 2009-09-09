Factory.sequence(:group_id) {|n| n + 1000}

Factory.define :site do |s|
  s.name              'Ruby Group'
  s.meetup_group_id   {Factory.next :group_id}
end