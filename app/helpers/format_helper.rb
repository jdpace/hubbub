module FormatHelper
  
  def boolean_flag(bool, text = nil)
    "<span class='flag #{bool.to_s}#{ ' labeled' unless text.nil?}'>#{text || bool.to_s}</span>"
  end
  
end