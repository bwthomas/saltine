require 'pry'
require 'prime-numbers'

module Saltine
  class Salt

    attr_accessor :salt, :salted, :unsalted

    def self.salt(*args)
      new(*args).salt
    end

    def initialize(*args)
      @salted     = []
      @aggressive = false

      if args.size == 1 && args.first.class <= Hash
        args = args.first

        @unsalted   = args[:unsalted] || args['unsalted']
        @salt       = args[:salt] || args['salt']

        @aggressive = args[:aggressive] || args['aggressive']
      else
        @unsalted = args
      end

    end

    def salt
      return @salt unless @salt.nil?
      elements  = [unsalted_cast].flatten.map {|a| a.to_a rescue a}.flatten
      numbers   = elements.select {|e| e.class <= Fixnum }
      max       = numbers.max ** 0.5
      primes    = ( max.to_i.downto(2).select { |i| sieve.is_prime?(i) } )
      @salt = primes.any? ? primes[rand(primes.size)] : 997
    end

    def salted
      return @salted unless @salted.empty?

      @salted = case unsalted_cast
        when Hash
          @salted = Hash[
            unsalted_cast.map do |key,value|
              [key, partition(value).salted]
            end
          ]
        when Enumerable
          @salted = unsalted_cast.map do |uns|
            partition(uns).salted
          end
        else
          @salted = (unsalted_cast.class <= Fixnum) ? unsalted_cast * salt : unsalted_cast
        end

      @salted
    end

    def reset
      @salted = []
      @salt   = nil
    end

    def unsalted_cast
      return unsalted unless aggressive?
      @unsalted_cast ||= ( unsalted.respond_to?(:to_i) ? unsalted.to_i : Integer(unsalted) ) rescue unsalted
    end
    private :unsalted_cast

    def partition(uns)
      self.class.new(:unsalted => uns, :salt => salt, :aggressive => aggressive?)
    end
    private :partition

    def sieve
      @sieve ||= PrimeNumbers::Generator.new(:sieve_of_eratosthenes)
    end
    private :sieve

    def aggressive?
      ['true', :true, true].include?(@aggressive)
    end

  end
end
