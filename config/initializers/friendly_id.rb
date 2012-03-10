#Babosa::Characters.add_approximations(:punc, {
#  "." => "dot",
#  "(" => "lparens",
#  ")" => "rparens"
#})

module FriendlyId
  class TaskRunner
    def refresh_slugs
      validate_uses_slugs
      cond = ""
      options = {:limit => 100, :include => :slugs, :conditions => cond, :order => "#{klass.table_name}.id ASC"}.merge(task_options || {})
      while records = find(:all, options) do
        break if records.size == 0
        records.each do |record|
          record.save(:validate => false)
          yield(record) if block_given?
        end
        options[:conditions] = "#{klass.table_name}.id > #{records.last.id}"
      end
    end
  end
end