ActiveSupport::CoreExtensions::Time::Conversions::DATE_FORMATS.merge!({
  :mdy          => "%m/%d/%y",
  :date_ordinal => lambda { |date| date.strftime("%A, %B #{date.day.ordinalize}")},
  :date_short   => lambda { |date| date.strftime("%b #{date.day.ordinalize}")},
  :full_ordinal => lambda { |time| time.strftime("%A, %B #{time.day.ordinalize}, %Y at %I:%M%p") },
  :calendar     => "%Y-%m-%d"
})
ActiveSupport::CoreExtensions::Date::Conversions::DATE_FORMATS.merge!({
  :date_ordinal => lambda { |date| date.strftime("%A, %B #{date.day.ordinalize} %Y")},
  :date_short   => lambda { |date| date.strftime("%b #{date.day.ordinalize}")}
})