require 'bunny'

connection = Bunny.new(automatically_recover: false)
connection.start

channel = connection.create_channel

queue = channel.queue('task_queue', durable: true)

message = ARGV.empty? ? "Hello World!" : ARGV.join(' ')

channel.default_exchange.publish(message, persistent: true, routing_key: queue.name)
puts " [x] Sent #{message}"

connection.close
