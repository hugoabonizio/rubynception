require 'spec_helper'

def load_asset(name)
  source = File.read(File.expand_path(File.dirname(__FILE__) + "/assets/#{name}.rb"))
  io = StringIO.new
  Rubynception::Compiler.new(source, false, io)
  io.string
end

describe Rubynception do
  it 'manage local variables operations' do
    expect('sum').to eq(load_asset('sum'))
  end

  it 'performs ifs statements' do 
    expect(load_asset('if')).to eq('1')
  end
end
