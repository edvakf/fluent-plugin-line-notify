[![Build Status](https://travis-ci.org/edvakf/fluent-plugin-line-notify.svg?branch=master)](https://travis-ci.org/edvakf/fluent-plugin-line-notify)

# fluent-plugin-line-notify

fluent-plugin-line-notify is a fluentd plugin to call LINE Notify API.

## Example Usage

`access_token` and `message_template` are the required config params. You can obtain your personal access token from [LINE Notify's my-page](https://notify-bot.line.me/my/).

    <source>
      @type        exec
      command      echo "foo\tbar"
      format       tsv
      keys         k1,k2
      tag          test.message
      run_interval 10s
    </source>

    <match test.message>
      @type            line_notify
      access_token     [Your personal access token obtained from https://notify-bot.line.me/my/]
      message_template You say <%= record['k1'] %>, I say <%= record['k2'] %>.
    </match>

## Testing

    bundle install
    bundle exec rake test

## Installation

    gem install fluent-plugin-line-notify

## Contributing

1. Fork it ( https://github.com/[my-github-username]/fluent-plugin-line-notify/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
