require 'spec_helper'

def load_asset(name)
  File.read(File.expand_path(File.dirname(__FILE__) + "/assets/#{name}.rb"))
end

describe Rubynception do
  it 'performs ifs statements' do
    source = load_asset('if')
    expect { Rubynception::Compiler.new(source) }.to output(1).to_stdout 
  end
end
