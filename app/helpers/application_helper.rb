module ApplicationHelper
  def currency_euro(item)
    number_to_currency(item, :unit => "€",
                             :separator => ",",
                             :delimiter => "",
                             :format => "%n %u")
  end
end
