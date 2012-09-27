# Brir

Brir is a interface to calculate the Brazilian Income Tax (Imposto de Renda Brasileiro - IRPF & IRPJ).  
This gem was created to solve a unique issue that is calculate how many money the brazilians will pay to your country over your anual income.

## Installation

Add this line to your application's Gemfile:

    gem 'brir'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install brir

## Usage

	require 'brir'
	
	# chose  the exercise year or leave blank to use actual year
	brir = Brir.new 2012
	
	# call tax method passing your taxable income
	income_tax_value = brir.tax 42000
	
	puts income_tax_value
	#=> 3109.53 

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
