# Primotexto

This is an unofficial Ruby client for the [Primotexto API](https://www.primotexto.com/api/).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'primotexto'
```

Or from Github to install the 'edge' version:

```ruby
gem 'primotexto', github: 'syntaxTerr0r/primotexto'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install primotexto

## Usage

All API methods are not implemented yet. Here is an exhaustive list of what is currently supported.
Methods naming try to follow the API naming, however some changes has been made to make some name more friendly.

### Initializing a new client

```ruby
pt = Primotexto.client(key: 'MY_SHINY_API_KEY')
```

Alternatively, you can define the key in an `ENV` variable: `PRIMOTEXTO_API_KEY`

```ruby
pt = Primotexto.client
```

### Sending SMS notification message

[API reference](https://www.primotexto.com/api/messages/send-notification.asp)

```ruby
message = pt.post_notification_message(number: '+33612345678', sender: 'Spiderman', message: 'Your new code is "W0WE".', category: 'codeConfirmation')
```

### Sending SMS marketing message

[API reference](https://www.primotexto.com/api/messages/send-marketing.asp)

```ruby
message = pt.post_marketing_message(number: '+33612345678', sender: 'Carwash', message: 'Get 30% off with this coupon: "W4SH" until tomorrow.')
```

See more about [E.164](https://en.wikipedia.org/wiki/E.164) phone formatting.

### Getting a message's status

[API reference](https://www.primotexto.com/api/messages/status.asp)

By phone number

```ruby
pt.get_messages_status(identifier: '+33612345678')
```

Or by snapshotId

```ruby
pt.get_messages_status(snapshotId: message[:snapshotId])
```

### Getting messages' stats

[API reference](https://www.primotexto.com/api/messages/stats.asp)

```ruby
pt.get_messages_stats(category: 'codeConfirmation')
```

### Getting a messages' replies

[API reference](https://www.primotexto.com/api/messages/callbacks.asp)

```ruby
pt.get_messages_replies(category: 'codeConfirmation')
```

### Getting messages' blacklists (Bounces + Unsubscribers)

[API reference](https://www.primotexto.com/api/account/stats.asp)

```ruby
pt.get_messages_blacklists(category: 'codeConfirmation')
```

### Unsubscribers

[API reference](https://www.primotexto.com/api/account/unsubscribers.asp)

#### Getting unsubscribers list

```ruby
pt.get_unsubscribers_contacts
```

#### Adding a phone number to unsubscribers list

```ruby
pt.post_unsubscribers_contacts(identifier: '+33612345678')
```

#### Removing a phone number from unsubscribers list

[API reference](https://www.primotexto.com/api/account/stats.asp)

```ruby
pt.delete_unsubscribers_contacts(identifier: '+33612345678')
```

### Bounces

[API reference](https://www.primotexto.com/api/account/bounces.asp)

#### Getting bounces list

```ruby
pt.get_bounces_contacts
```

#### Adding a phone number to bounces list

```ruby
pt.post_bounces_contacts(identifier: '+33612345678')
```

#### Removing a phone number from bounces list

[API reference](https://www.primotexto.com/api/account/stats.asp)

```ruby
pt.delete_bounces_contacts(identifier: '+33612345678')
```

### Contacts lists

[API reference](https://www.primotexto.com/api/lists/contacts/index.asp)

#### Creating a list

```ruby
vip_list = pt.post_lists(name: 'VIP People')
```

#### Adding a contact to a list

```ruby
vip_contact = pt.post_list_contact(list_id: vip_list[:id], identifier: '+33612345678')
```

#### Removing a contact from a list

```ruby
pt.delete_list_contact(list_id: vip_list[:id], contact_id: vip_contact[:id], identifier: '+33612345678')
```

### Getting you account stats

[API reference](https://www.primotexto.com/api/account/stats.asp)

```ruby
pt.get_account_stats
```

## Testing

This gem has no specs yet.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/syntaxTerr0r/primotexto.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
