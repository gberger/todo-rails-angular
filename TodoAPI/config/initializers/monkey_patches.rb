class ActiveModel::Errors
  def angular_growl_messages
    full_messages.map do |message|
      {text: message, severity: "error"}
    end
  end
end

class ActiveRecord::Base
  def permit(*filters)
    params = {}

    filters.flatten.each do |filter|
      case filter
        when String then
          params[filter] = self[filter]
        when Symbol then
          params[filter] = self.send(filter)
      end
    end

    params
  end
end