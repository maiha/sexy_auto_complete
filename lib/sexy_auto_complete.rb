module SexyAutoComplete
  def self.included(base)
    base.class_eval do
      include SexyAutoComplete::Controller
      before_filter :auto_complete_read_input
    end
  end
end
