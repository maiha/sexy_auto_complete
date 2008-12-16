# install javascripts

src = File.dirname(__FILE__) + "/files/multicontrols.js"
dst = RAILS_ROOT + "/public/javascripts/multicontrols.js"
if !File.exist?(dst) or File.mtime(dst) < File.mtime(src)
  if (logger = ActionController::Base.logger)
    logger.debug "[AutoComplete plugin] install multicontrols.js to #{dst}"
  end
  FileUtils.cp(src, dst)
end

# apply new methods to ApplicationHelper

ApplicationHelper.module_eval do
  include AutoComplete::Helper
end
