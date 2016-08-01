module FormStalker
  class Response
    RAILS_HTTP_STATUS = {
      '100' => :continue,
      '101' => :switching_protocols,
      '102' => :processing,
      '200' => :ok,
      '201' => :created,
      '202' => :accepted,
      '203' => :non_authoritative_information,
      '204' => :no_content,
      '205' => :reset_content,
      '206' => :partial_content,
      '207' => :multi_status,
      '226' => :im_used,
      '300' => :multiple_choices,
      '301' => :moved_permanently,
      '302' => :found,
      '303' => :see_other,
      '304' => :not_modified,
      '305' => :use_proxy,
      '307' => :temporary_redirect,
      '400' => :bad_request,
      '401' => :unauthorized,
      '402' => :payment_required,
      '403' => :forbidden,
      '404' => :not_found,
      '405' => :method_not_allowed,
      '406' => :not_acceptable,
      '407' => :proxy_authentication_required,
      '408' => :request_timeout,
      '409' => :conflict,
      '410' => :gone,
      '411' => :length_required,
      '412' => :precondition_failed,
      '413' => :request_entity_too_large,
      '414' => :request_uri_too_long,
      '415' => :unsupported_media_type,
      '416' => :requested_range_not_satisfiable,
      '417' => :expectation_failed,
      '422' => :unprocessable_entity,
      '423' => :locked,
      '424' => :failed_dependency,
      '426' => :upgrade_required,
      '500' => :internal_server_error,
      '501' => :not_implemented,
      '502' => :bad_gateway,
      '503' => :service_unavailable,
      '504' => :gateway_timeout,
      '505' => :http_version_not_supported,
      '507' => :insufficient_storage,
      '510' => :not_extended
    }.freeze

    attr_reader :error, :status

    attr_accessor :data

    def initialize(http_response)
      @http_response = http_response

      @status = RAILS_HTTP_STATUS[@http_response.code]

      @data = JSON.parse(@http_response.body) if @status == :ok

      parse_error
    end

    def ok?
      status == :ok && (error.nil? || error == '')
    end

    protected ######################## PROTECTED ###############################

    def parse_error
      @error =
        case status
        when :ok
          @data.is_a?(Hash) ? @data['error'] : nil
        when :unauthorized
          'Either your oauth token is invalid ' \
          "or you don't have access to this resource"
        else
          status
        end
    end
  end
end
