module FormStalker
  module Data
    class Parser
      attr_reader :object, :type_cast_schema, :attributes_before_type_cast

      def initialize(object, type_cast_schema, attributes)
        @object = object
        @type_cast_schema = type_cast_schema
        @attributes_before_type_cast = attributes.dup
      end

      def parse_attributes
        attributes = {}

        attributes_before_type_cast.each do |key, value|
          attributes[key] = parse_attribute key, value
        end

        attributes
      end

      def parse_attribute(key, value)
        if object.respond_to?("parse_#{key}")
          return object.send("parse_#{key}", value)
        end

        return value unless type_cast_schema[key.to_sym]

        send("sanitize_#{type_cast_schema[key.to_sym]}", value)
      end

      def sanitize_boolean(value)
        ![false, 0, '0', 'false', 'FALSE'].include?(value)
      end

      def sanitize_integer(value)
        value.to_i if value.to_s =~ /\A[+-]?\d+\Z/
      end

      def sanitize_datetime(value)
        DateTime.parse(value)
      rescue
        value
      end
    end
  end
end
