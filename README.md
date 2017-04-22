Oyster Card Challenge
======

A programme that mimics the functionality of a TFL Oyster Card. 

## Getting Started

### Requirements

1. IRB/PRY
2. [Ruby](https://www.ruby-lang.org/en/documentation/installation/)
3. [RSpec](http://rspec.info/)

### Installing

1. Clone this repo to local machine. 
2. The programme runs directly from the Command Line in IRB or PRY. Navigate to your cloned oyster-card-1 directory and run preferred tool:

**IRB**

* If you’re using Mac OS X open up Terminal and type `irb`, then hit enter.
* If you’re using Linux, open up a shell and type `irb` and hit enter.
* If you’re using Windows, open `Interactive Ruby` from the Ruby section of your Start Menu.

**PRY**
```
$ gem install pry
$ pry
```

## PRY example 
```
[1] pry(main)> require './lib/oystercard'
=> true
[2] pry(main)> card = Oystercard.new
=> #<Oystercard:0x007fb5468843b8 @balance=0, @journey=#<Journey:0x007fb546884318>, @journey_history=[]>
[3] pry(main)> card.top_up(50)
=> 50
[4] pry(main)> card.touch_in('Peckham')
=> "Peckham"
[5] pry(main)> card
=> #<Oystercard:0x007fb5468843b8 @balance=50, @journey=#<Journey:0x007fb546884318 @entry_station_name="Peckham">, @journey_history=[]>
[6] pry(main)> card.touch_out('Dalston')
=> nil
[7] pry(main)> card
=> #<Oystercard:0x007fb5468843b8
 @balance=49,
 @journey=#<Journey:0x007fb546884318 @entry_station_name=nil, @exit_station_name="Dalston">,
 @journey_history=[{:entry_station=>"Peckham", :exit_station=>"Dalston"}]>
```

## Running the tests

Run tests with RSpec. From cloned oyster-card-1 directory, enter:

`$ rspec`

to run tests.

## User Stories
```
In order to use public transport
As a customer
I want money on my card

In order to keep using public transport
As a customer
I want to add money to my card

In order to protect my money
As a customer
I don't want to put too much money on my card

In order to pay for my journey
As a customer
I need my fare deducted from my card

In order to get through the barriers
As a customer
I need to touch in and out

In order to pay for my journey
As a customer
I need to have the minimum amount for a single journey

In order to pay for my journey
As a customer
I need to pay for my journey when it's complete

In order to pay for my journey
As a customer
I need to know where I've travelled from

In order to know where I have been
As a customer
I want to see to all my previous trips

In order to know how far I have travelled
As a customer
I want to know what zone a station is in

In order to be charged correctly
As a customer
I need a penalty charge deducted if I fail to touch in or out

In order to be charged the correct amount
As a customer
I need to have the correct fare calculated
```
