require "pager/version"

module Pager
  def self.included(base)
    base.send :include, InstanceMethods

    base.send :attr_accessor, :current_offset, :default_batch, :current_index
  end

  module InstanceMethods
    def filtered_page(limit, options={}, &block)
      self.default_batch = options.delete(:default_batch) || 1
      self.current_index = index(self.current_offset || options.delete(:offset) || first)

      catch(:filtered) do
        collected = []
        while collected.length != limit
          new_batch = next_batch
          throw(:filtered, collected) if new_batch.empty?

          new_batch.each do |x|
            collected << x if yield(x)

            if collected.size == limit
              self.current_offset = index(x) == index(last) ? first : self[index(x) + 1]
              throw :filtered, collected
            end
          end
        end
      end
    end

    def next_batch
      index_start = self.current_index
      index_end = index_start + self.default_batch
      self.current_index = index_end + 1
      dup[index_start..index_end] || []
    end
  end
end
