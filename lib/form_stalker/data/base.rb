module FormStalker
  module Data
    class Base < OpenStruct
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
    end
  end
end
