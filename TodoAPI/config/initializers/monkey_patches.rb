class ActiveModel::Errors
  def angular_growl_messages
    full_messages.map do |message|
      {text: message, severity: "error"}
    end
  end
end

class ActiveRecord::Base
  def pick(*filters)
    params = {}

    filters.flatten.each do |filter|
      case filter
        when String, Fixnum then
          params[filter] = self[filter]
        when Symbol then
          params[filter] = self.send(filter)
        when Hash then
          params.merge filter
      end
    end

    params
  end
end