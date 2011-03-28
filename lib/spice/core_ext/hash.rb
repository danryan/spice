class Hash
  def symbolize_keys!
    keys.each do |key|
      self[(key.to_sym rescue key) || key] = delete(key)
    end
    self
  end
  def symbolize_keys
    dup.symbolize_keys!
  end
end