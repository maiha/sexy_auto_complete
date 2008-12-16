module AutoComplete
  module Helper
    def auto_complete_for(record_name, column_name, target_options = {}, suggest_options = {}, trigger_options = {})
      record     = instance_variable_get("@#{record_name}")
      model_name = record.class.name.demodulize.underscore
      controller = target_options.delete(:controller) || model_name
      action     = target_options.delete(:action) || "auto_complete_#{column_name}"
      field_name = target_options.delete(:name) || column_name

      # target
      target_id = field_name.gsub(/\[|\]/, '_')
      options   = {:name=>field_name, :id=>target_id, :class=>"#{column_name}-input", :size=>20}.merge(trigger_options)
      target    = input(record_name, column_name, options)

      # suggest
      options     = {:id=>"#{target_id}_auto_complete", :class=>"auto_complete", :style=>"width:400px;"}.merge(suggest_options)
      suggest     = content_tag('div', '', options)

      # trigger
      url = {:controller=>controller, :action=>action, :id=>target_id, :path=>field_name}
      options = {:url=>url, :min_chars=>3}.update(trigger_options)
      trigger = auto_complete_field target_id, options

      target + suggest + trigger
    end

    private
      def auto_complete_includes
        auto_complete_javascript + auto_complete_stylesheet
      end

      def auto_complete_javascript
        javascript_include_tag "multicontrols"
      end

      def auto_complete_stylesheet
        super +
          content_tag('style', <<-EOT, :type => 'text/css')
            div.auto_complete {
              color: black;
            }
            div.auto_complete ul li {
              background-color: #fff;
            }
          EOT
      end
  end
end
