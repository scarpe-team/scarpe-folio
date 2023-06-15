# Scarpe-Folio

Scarpe is a recent implementation of Shoes which tries to stay agnostic about what display library to use. Scarpe's main gem uses Webview, but it also allows implementing other display services of various sorts.

Scarpe-Folio is a gemified LibUI-based Scarpe display service.

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add scarpe-folio

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install scarpe-folio

## Usage

Once Scarpe-Folio is installed, you can use the "folio" command to run Shoes apps:

    $ folio examples/button_alert.rb

This is primarily the same as the "scarpe" command, including supporting --dev and --debug flags, but it defaults the display service to be scarpe-folio.

To run with the local non-installed copy of Folio (common for development), use the --dev flag:

    $ bundle exec ./exe/folio --dev examples/button_alert.rb

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bundle exec rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/scarpe-team/scarpe-folio. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/scarpe-team/scarpe-folio/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Scarpe::Folio project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/scarpe-team/scarpe-folio/blob/main/CODE_OF_CONDUCT.md).
