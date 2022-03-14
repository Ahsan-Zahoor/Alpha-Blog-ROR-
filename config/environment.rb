# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!

# Get rid of error settings(field_with_errors) that rails is setting in input field by default.
ActionView::Base.field_error_proc=Proc.new do |html_tag,instance|
  html_tag.html_safe
end