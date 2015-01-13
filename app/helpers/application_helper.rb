module ApplicationHelper
  def my_name
    self.name
  end
  def searx filters_hash={}, order=nil
    my_name.constantize.all
  end
end
