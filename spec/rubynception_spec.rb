require 'spec_helper'
require 'stringio'

def load_asset(name)
  source = File.read(File.expand_path(File.dirname(__FILE__) + "/assets/#{name}.rb"))
  io = StringIO.new
  Rubynception::Compiler.new(source, false, io)
  io.string
end

describe Rubynception do
  it 'manage local variables operations' do
    expect(load_asset('sum')).to eq("4\n")
  end

  it 'performs ifs statements' do 
    expect(load_asset('if')).to eq("1\n")
  end

  it 'performs while statements' do
    expect(load_asset('while')).to eq("10001\n0\n")
  end

  it 'performs fibonacci' do
    expect(load_asset('fib')).to eq("1\n1\n2\n3\n5\n8\n13\n")
  end
end
