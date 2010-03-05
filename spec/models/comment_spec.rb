require 'spec_helper'

describe Comment do
  should_validate_presence_of :body, :commentable
  should_validate_presence_of :author_name, :if => Proc.new { |c| c.user.nil? }
  
end
