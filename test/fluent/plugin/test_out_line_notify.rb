require 'helper'

class LineNotifyOutputTest < Test::Unit::TestCase
  def setup
    Fluent::Test.setup
  end

  CONFIG = %[
    access_token     123abc
    message_template You say <%= record['k1'] %>, I say <%= record['k2'] %>.
  ]

  def create_driver(conf=CONFIG, tag='test', use_v1=true)
    Fluent::Test::OutputTestDriver.new(Fluent::LineNotifyOutput, tag).configure(conf, use_v1)
  end

  test "`access_token` must be present" do
    assert_raise(Fluent::ConfigError) {
      create_driver('')
    }
  end

  test "emit" do
    d = create_driver()

    mock(HTTParty).post('https://notify-api.line.me/api/notify', headers: {'Authorization' => 'Bearer 123abc', 'Content-Type' => 'application/x-www-form-urlencoded'}, body: 'message=You+say+foo%2C+I+say+bar.')

    d.emit({'k1' => 'foo', 'k2' => 'bar'})
    d.run
  end
end
