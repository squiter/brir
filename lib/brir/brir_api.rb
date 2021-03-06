module Brir
  class  BrirApi
    attr_accessor :exercise_year, :calendar_year, :ranges

    def initialize(exercise_year = nil)
      @exercise_year = (exercise_year.nil?) ? Time.new.year : exercise_year
      @calendar_year = @exercise_year.to_i - 1
      @ranges = table(@exercise_year)
      raise "Fail to initialize the progressive table" if @ranges.nil?
    end

    def tax(income)

      # prevent negative incomes
      income = income.to_f.round 2
      return 0.00 unless income > 0

      case income
        when @ranges["second"]["from"]..@ranges["second"]["to"]
          total = calc_second_range(income)
        when @ranges["third"]["from"]..@ranges["third"]["to"]
          total = calc_third_range(income)
        when @ranges["fourth"]["from"]..@ranges["fourth"]["to"]
          total = calc_fourth_range(income)
        when @ranges["fifth"]["from"]..(1.0/0.0)
          total = calc_fifth_range(income)
        else
          total = 0.00
      end
      total.to_f.round 2
    end

    private
    def set_progressive_table()
      require 'yaml'

      begin
        # Trying to get brir.yml into config path, for Rails Applications
        file = File.join(Rails.root, "config", "brir.yml")

        # I realy don't know if this is the best solution to this
        unless File.exists? file
          file = File.join(File.dirname(__FILE__),"table_source", "progressiveTable.yml")
        end
      rescue
        file = File.join(File.dirname(__FILE__),"table_source", "progressiveTable.yml")
      end

      begin
        yaml = YAML.load_file(file)
      rescue Errno::ENOENT
        raise "Brir fails to load progressive table"
      end
    end

    def table(exercise_year)
      yaml = set_progressive_table()
      begin
        yaml[exercise_year]["ranges"]
      rescue Exception => e
        nil
      end
    end

    def calc_second_range(income)
      (((income.to_f - @ranges["second"]["from"])*@ranges["second"]["aliquot"])/100)
    end

    def calc_third_range(income)
      total = (((@ranges["second"]["to"] - @ranges["second"]["from"])*@ranges["second"]["aliquot"])/100)
      total = (total.round 2) + (((income.to_f - @ranges["second"]["to"])*@ranges["third"]["aliquot"])/100)
      total
    end

    def calc_fourth_range(income)
      total = (((@ranges["second"]["to"] - @ranges["second"]["from"])*@ranges["second"]["aliquot"])/100)
      total = (total.round 2) + (((@ranges["third"]["to"] - @ranges["second"]["to"])*@ranges["third"]["aliquot"])/100)
      total = (total.round 2) + (((income.to_f - @ranges["third"]["to"])*@ranges["fourth"]["aliquot"])/100)
      total
    end

    def calc_fifth_range(income)
      total = (((@ranges["second"]["to"] - @ranges["second"]["from"])*@ranges["second"]["aliquot"])/100)
      total = (total.round 2) + (((@ranges["third"]["to"] - @ranges["second"]["to"])*@ranges["third"]["aliquot"])/100)
      total = (total.round 2) + (((@ranges["fourth"]["to"] - @ranges["third"]["to"])*@ranges["fourth"]["aliquot"])/100)
      total = (total.round 2) + (((income.to_f - @ranges["fourth"]["to"])*@ranges["fifth"]["aliquot"])/100)
      total
    end

  end
end