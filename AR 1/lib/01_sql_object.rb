require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    return @columns if @columns

    columns = DBConnection.execute2(<<-SQL)
      SELECT
        *
      FROM
        #{self.table_name}
      LIMIT
        0
    SQL
    @columns = columns.first.map!(&:to_sym)
    @columns
    # ...
  end

  def self.finalize!
    columns.each do |column|
      define_method(column.to_s) do
        attributes[column]
      end
      define_method("#{column}=") do |given|
        attributes[column] = given
      end
    end


  end

  def self.table_name=(table_name)

    @table_name = table_name
    # ...
  end

  def self.table_name
    # ...
      @table_name = self.to_s.underscore + "s"
  end

  def self.all
    hashes = DBConnection.execute(<<-SQL)
      SELECT
        *
      FROM
        #{self.table_name}
    SQL
    parse_all(hashes)
  end

  def self.parse_all(results)
    results.each do |result|
      Cat.new(result)
    end
    # ...
  end

  def self.find(id)
    # ...
  end

  def initialize(params = {})
    @params = params
    class_columns = self.class.columns
    params.each do |param, value|
      param = param.to_sym
      unless class_columns.include?(param)
        raise "unknown attribute '#{param}'"
      end
      self.send(param.to_s +  "=", value)
    end
  end


  def attributes
    @attributes ||= @params
    @attributes ||= {}
    @attributes
    # ...
  end

  def attribute_values
    # ...
  end

  def insert
    # ...
  end

  def update
    # ...
  end

  def save
    # ...
  end
end
