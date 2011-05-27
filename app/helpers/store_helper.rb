module StoreHelper
  
  def display(string_to_change)
    string_to_change.gsub(/_/,' ').split(' ').map {|w| w.capitalize }.join(' ')
  end


end
