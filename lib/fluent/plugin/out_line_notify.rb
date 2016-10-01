require 'fluent/output'
require 'httparty'
require 'erb'
require 'cgi'

module Fluent
  class Templater < OpenStruct
    def result(erb)
      erb.result(binding)
    end
  end

  class LineNotifyOutput < Output
    Fluent::Plugin.register_output('line_notify', self)

    config_param :access_token,     :string
    config_param :message_template, :string
    config_param :api_url,          :string, default: 'https://notify-api.line.me/api/notify'

    # Define `log` method for v0.10.42 or earlier
    unless method_defined?(:log)
      define_method("log") { $log }
    end

    def configure(conf)
      super

      @erb = ERB.new(@message_template)
    end

    def emit(tag, es, chain)
      es.each do |time, record|
        t = Templater.new
        t.tag = tag
        t.time = time
        t.record = record
        msg = t.result(@erb)

        begin
          resp = HTTParty.post(
            @api_url,
            headers: {
              'Authorization' => "Bearer #{@access_token}",
              'Content-Type' => 'application/x-www-form-urlencoded',
            },
            body: "message=#{CGI.escape(msg)}"
          )
          raise resp.message if resp.code != 200
        rescue
          $log.warn "raises exception: #{$!.class}, '#{$!.message}, #{t}'"
        end
      end

      chain.next
    end
  end
end
