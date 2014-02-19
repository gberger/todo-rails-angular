class ActiveModel::Errors
  def angular_growl_messages
    full_messages.map do |message|
      {text: message, severity: "error"}
    end
  end
end
