module AutoComplete
  module Controller
  private
    def auto_complete_read_input
      # [params]
      # "record" => {"item_locations"=>{"1229373405139"=>{"position"=>"ITN"}}},
      # "path"   => "record[item_locations][1229373405139][position]",
      @input = params[:path].to_s.split(%r{[\[|\]/]+}).inject(params){|hash, key| hash[key]}.to_s.strip
      if @input.blank?
        render :nothing=>true
        return false
      end
      return true
    end

    def auto_complete(records, options = {}, &block)
      block ||= proc{|r| r.respond_to?(:to_label) ? r.to_label : (r.respond_to?(:name) ? r.name : r.id)}
      if records.blank? and !(options[:blank] == false)
        suggest = options[:blank]
        suggest = auto_complete_response_not_found unless suggest.is_a?(String)
      else
        suggest = records.map{|r| block.call(r)}
      end
      auto_complete_render(suggest)
    end

    def auto_complete_wrap(response)
      case response
      when Array
        "<ul>%s</ul>" % response.map{|i| "<li>#{i}</li>"}.join
      when /^<ul.*?>/
        response
      when /^<li.*?>/
        "<ul>#{response}</ul>"
      else
        "<ul><li>#{response}#{auto_complete_nop}</li></ul>"
      end
    end

    def auto_complete_response_not_found
      "No Match"
    end

    def auto_complete_response_not_implemented
      "Cannot complete : Please define [#{controller_name.to_s.classify}##{action_name}] action"
    end

    def auto_complete_connect(to, data = nil)
      "<span connect='#{to}'>#{data}</span>"
    end

    def auto_complete_nop
      "<span connect='__no_such_element__' style='display:none;'></span>"
    end

    def auto_complete_render(value)
      value = auto_complete_wrap(value)
      # logger.debug "[AUTO COMPLETE] (%s) -> %s" % [@input, value]
      render :text=>value
    end

    def rescue_action(error)
      # I don't know why it fails to accessing to ActionController::UnknownAction directly
      # => uninitialized constant ActionWebService::Dispatcher::ActionController::UnknownAction
      case error.class.name
      when "ActionController::UnknownAction"
        if auto_complete_response_not_implemented
          auto_complete_render auto_complete_response_not_implemented
          return
        end
      end

      super
    end
  end
end
