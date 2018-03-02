class AttrAccessorObject
  def self.my_attr_accessor(*names)
    p names
    names.map!(&:to_s)
    names.each do |var|
      var_sym = var.to_sym
      var_equal_sym = "#{var}=".to_sym
      var_instance = "@#{var}".to_sym
      var_ins_set = "@#{var}=".to_sym

      define_method(var_sym) { instance_variable_get(var_instance) }
      define_method(var_equal_sym) { |given| instance_variable_set(var_instance, given)}
      # define_method()
    end
  end
end
