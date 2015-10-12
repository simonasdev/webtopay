WebToPay
===========

This gem provides WebToPay (mokejimai.lt) Ruby API implementation with some useful Rails helpers

Installation
===========

Add to your Gemfile:
```
gem 'webtopay', git: 'https://github.com/simonasdev/webtopay.git'
```
Run:b
```
bundle install
```

Configuration
===========

Create initializer
config/initializers/webtopay.rb

```ruby
WebToPay.configure do |config|
  config.project_id     = 00000
  config.sign_password  = 'your sign password'
end
```

Usage
===========

Protect accepturl, cancelurl, callbackurl actions in controllers:

```ruby
  include WebToPay::ControllerHelper
  webtopay :accept, :cancel, :callback

  def accept
    # write here code which do some stuff
    # use instance variable "webtopay_data" to access data from mokejimai.lt
    render text: "Your payment #{webtopay_data[:orderid]} has been successfully received. Thank you!"
  end

  def callback
    # write here code which do some stuff
    render text: "OK"
  end
```

You can also use helper method to generate required form for MACRO payments in templates:
app/helpers/application_helper.rb:
```ruby
  include WebToPay::Helper
```
Any template (please note that the form doesn't contain any submit button, it needs to be submitted with JS)
```ruby
<%= webtopay_macro_form test: 1, orderid: 123, amount: 2000, payment: 'vb', country: 'lt', paytext: "Billing for XX at the website XXX" %>

```

===========
Copyright (c) 2013 Kristijonas Urbaitis, released under the MIT license
