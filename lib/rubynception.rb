require 'pp'
require File.expand_path(File.dirname(__FILE__) + '/rubynception/version')
require File.expand_path(File.dirname(__FILE__) + '/rubynception/machine')

# https://github.com/ruby/ruby/blob/trunk/insns.def

module Rubynception
  class Compiler
    def initialize(source, debug = false, stdout = STDOUT)
      magic, major_version, minor_version, format_type, misc,
      name, filename, filepath, line_no, type, locals, args,
      catch_table, bytecode = RubyVM::InstructionSequence.compile(source).to_a

      pp bytecode if debug
      puts '=============' if debug

      Rubynception::Machine.new(bytecode, stdout).run
    end
  end
end
