module AutoComplete
  def self.included(base)
    base.class_eval do
      include AutoComplete::Controller
      before_filter :auto_complete_read_input
    end
  end
end
