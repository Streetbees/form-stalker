module FormStalker
  module Helpers
    module_function

    def json_to_hash(string)
      JSON.parse(string)
    end

    def string_to_array_of_integers(string)
      string.delete("'").delete('"').split(',').map(&:to_i)
    end

    def extract_from_regex(string, regex)
      string.scan(regex).flatten
    end
  end
end
