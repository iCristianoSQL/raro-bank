module FlashHelper
  def flash_class(key)
    case key
    when "notice"
      "alert-success"
    when "alert", "error"
      "alert-danger"
    else
      "alert-info"
    end
  end
end
