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

## Progressive Table

This gem already have a progressive table with the following exercise years (Financial Year):  

* 2012  
* 2013  
* 2014  
* 2015

If you want to use your own Progressive Table, you must to create a YAML file into your config path. (Only for Rails Applications).  
The file must be like these:  

	2012:
	  ranges:
	    first:
	      from: 0
	      to: 18799.32
	      aliquot:
	      portion: 0
	    second:
	      from: 18799.33
	      to: 28174.20
	      aliquot: 7.5
	      portion: 1409.95
	    third:
	      from: 28174.21
	      to: 37566.12
	      aliquot: 15
	      portion: 3523.01
	    fourth:
	      from: 37566.13
	      to: 46939.56
	      aliquot: 22.5
	      portion: 6340.47
	    fifth:
	      from: 46939.57
	      to:
	      aliquot: 27.5
	      portion: 8687.45


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
