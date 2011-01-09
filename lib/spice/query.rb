# encoding: UTF-8
# Lovingly yanked from http://github.com/jnunemaker/plucky

require 'forwardable'

module Spice
  class Query
    include Enumerable
    extend Forwardable

    def initialize(collection, options={})
      @collection, @options, @criteria = collection, OptionsHash.new, CriteriaHash.new
      options.each { |key, value| self[key] = value }
    end

    def initialize_copy(source)
      super
      @criteria = @criteria.dup
      @options = @options.dup
    end

    def object_ids(*keys)
      return criteria.object_ids if keys.empty?
      criteria.object_ids = *keys
      self
    end

    def find_each(options={})
      query = clone.update(opts)
      query.collection.find(query.criteria.to_hash, query.options.to_hash)
    end

    def find(*ids)
      return nil if ids.empty?
      if ids.size == 1 && !ids[0].is_a?(Array)
        first(:_rev => ids.flatten)
      else
        all(:id => ids.flatten)
      end
    end

    def all(options={})
      find_each(options).to_a
    end

    def first(options={})
      find_one(options)
    end

    def last(options={})
      clone.update(options).reverse.find_one
    end

    def count(options={})
      find_each(options).count
    end

    def size
      count
    end

    def update(options={})
      options.each { |key, value| self[key] = value }
      self
    end


    def ignore(*args)
      set_fields(args,0)
    end

    def only(*args)
      set_fields(args,1)
    end    

    def limit(count=nil)
      clone.tap { |query| query.options[:limit] = count }
    end

    def reverse
      clone.tap do |query|
        query[:sort].map! do |s|
          [s[0], -s[1]]
        end unless query.options[:sort].nil?
      end
    end

    def skip(count=nil)
      clone.tap { |query| query.options[:skip] = count }
    end
    alias offset skip

    def sort(*args)
      clone.tap { |query| query.options[:sort] = *args }
    end
    alias order sort

    def where(hash={})
      clone.tap do |query|
        query.criteria.merge!(CriteriaHash.new(hash))
      end
    end

    def empty?
      count.zero?
    end

    def exists?(options={})
      !count(options).zero?
    end
    alias :exist? :exists?

    def to_a
      all
    end

    def [](key)
      key = key.to_sym if key.respond_to?(:to_sym)
      if OptionKeys.include?(key)
        @options[key]
      else
        @criteria[key]
      end
    end

    def []=(key, value)
      key = key.to_sym if key.respond_to?(:to_sym)
      if OptionKeys.include?(key)
        @options[key] = value
      else
        @criteria[key] = value
      end
    end

    def merge(other)
      merged_criteria = criteria.merge(other.criteria).to_hash
      merged_options  = options.merge(other.options).to_hash
      clone.update(merged_criteria).update(merged_options)
    end

    def to_hash
      criteria.to_hash.merge(options.to_hash)
    end

    def explain
      collection.find(criteria.to_hash, options.to_hash).explain
    end

    def inspect
      as_nice_string = to_hash.collect do |key, value|
        " #{key}: #{value.inspect}"
      end.sort.join(",")
      "#<#{self.class}#{as_nice_string}>"
    end

    private

    def set_fields(field_list, value)
      the_fields = {}
      field_list.each {|field| the_fields[field.to_sym] = value}
      clone.tap { |query| query.options[:fields] =  the_fields}
    end
    
  end
end
