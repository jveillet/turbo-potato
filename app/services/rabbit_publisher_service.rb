##
# RabbitMQ Publisher Service
#
# This class is managig connection and publication on
# a RabibttMQ instance.
#
class RabbitPublisherService
  DEFAULT_QUEUE = ENV['RABBITMQ_DEFAULT_QUEUE'] || 'rides'

  ##
  # Connection
  #
  # Instanciate a new connection to RabbitMQ
  # The host is read from the RABBITMQ_URL in the env variables (dotenv-rails)
  #
  def self.connection
    @connection ||= begin
                      connection = Bunny.new
                      connection.start
                    rescue Interrupt => _
                      connection.close
                    end
  end

  ##
  # Publish message on the default default exchange
  #
  # @param message [String] The message containing the object to publish in RabbitMQ
  #
  def self.publish(message = {})
    channel.queue(DEFAULT_QUEUE)
    default_exchange.publish(message.to_json, routing_key: DEFAULT_QUEUE)
  end

  def self.default_exchange
    channel.default_exchange
  end

  def self.channel
    @channel ||= connection.create_channel
  end
end
