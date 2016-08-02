require 'form_stalker/data/parser'

module FormStalker
  module Data
    class Base < OpenStruct
      def self.schema(options = nil)
        type_cast_schema.merge! options
      end

      def self.type_cast_schema
        @type_cast_schema ||= { id: :integer }
      end

      def self.inherited(base)
        base.type_cast_schema.merge! type_cast_schema.clone

        super
      end

      def self.tap_into(response)
        return response unless response.ok?

        response.data =
          if response.data.is_a?(Array)
            response.data.map { |subset| new(subset) }
          else
            new(response.data)
          end

        response
      end

      alias attributes marshal_dump

      attr_reader :parser

      def initialize(attributes = nil)
        attributes ||= {}

        instance_variable_set('@table', attributes)

        @parser = Parser.new(self, self.class.type_cast_schema, attributes)

        super(@parser.parse_attributes)
      end

      def attributes_before_type_cast
        parser.attributes_before_type_cast
      end
    end
  end
end
