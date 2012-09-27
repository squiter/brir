require 'spec_helper'

describe Brir do
  it 'should return a calendar year for a exercise year' do
    brir = Brir.new(2015)
    brir.should_not be_nil
    brir.calendar_year.should == 2014
  end
  
  it 'should return a calendar year whithout a exercise year' do
    brir = Brir.new
    brir.should_not be_nil
    brir.calendar_year.should == (Time.new.year.to_i - 1)
  end
  
  it 'should consume the progressive table' do
    brir = Brir.new(2012)
    brir.ranges["first"]["from"].should == 0
    brir.ranges["fifth"]["to"].should be_nil
  end
  
  it 'should know which incomes are free for taxes' do
    brir = Brir.new(2012)
    brir.tax(-20).should == 0.00
    brir.tax(10000.00).should == 0.00
    brir.tax(15000.00).should == 0.00
    brir.tax(17500.43).should == 0.00
    brir.tax(18700.30).should == 0.00
    brir.tax(18799.32).should == 0.00
  end
  
  it 'should calculate all secound range incomes' do
    brir = Brir.new(2012)
    brir.tax(18799.32).should == 0.00 
    brir.tax(18799.40).should == 0.01
    brir.tax(28000).should == 690.05
    brir.tax(19500).should == 52.55
    brir.tax(19600.34).should == 60.08
    brir.tax(27699.20).should == 667.49
    brir.tax(28174.20).should == 703.12
  end
  
  it 'should calculate all third range incomes' do
    brir = Brir.new 2012
    brir.tax(28174.21).should == 703.12
    brir.tax(28174.40).should == 703.15
    brir.tax(30000).should == 976.99
    brir.tax(35500).should == 1801.99
    brir.tax(37004.20).should == 2027.62
    brir.tax(35666.50).should == 1826.96
    brir.tax(37566.12).should == 2111.91
  end
  
  it 'should calculate all fourth range incomes' do
    brir = Brir.new 2012
    brir.tax(37566.13).should == 2111.91
    brir.tax(37566.23).should == 2111.93
    brir.tax(38000).should == 2209.53
    brir.tax(40000).should == 2659.53
    brir.tax(43560.98).should == 3460.75
    brir.tax(46830).should == 4196.28
    brir.tax(46830).should == 4196.28
    brir.tax(46939.56).should == 4220.93
  end
  
  it 'should calculate all fifth range incomes' do
    brir = Brir.new 2012
    brir.tax(46939.57).should == 4220.93
    brir.tax(46939.66).should == 4220.96
    brir.tax(47000).should == 4237.55
    brir.tax(49666.40).should == 4970.81
    brir.tax(69700.00).should == 10480.05
    brir.tax(142500.00).should == 30500.05
    brir.tax(14250000.00).should == 3910062.55
  end
end