require "pager/version"

module Pager
  def self.included(base)
    base.send :include, InstanceMethods

    base.send :attr_accessor, :last_offset, :default_batch, :current_index
  end

  module InstanceMethods
    def filtered_page(limit, options={}, &block)
      self.default_batch = options.delete(:default_batch) || 10
      self.current_index = (options.include?(:offset) and !options[:offset].blank?) ? index(options.delete(:offset)) : (self.last_offset.nil? ? 0 : index(self.last_offset)+1)

      catch(:filtered) do
        collected = []
        while collected.length != limit
          new_batch = next_batch
          if new_batch.empty?
            self.last_offset = last
            throw(:filtered, collected)
          end

          new_batch.each do |x|
            collected << x if yield(x)

            if collected.size == limit
              self.last_offset = self[index(x)]
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
