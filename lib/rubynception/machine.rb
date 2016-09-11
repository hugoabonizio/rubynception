module Rubynception
  class Machine
    def initialize(bytecode, io)
      @bytecode = bytecode
      @stack = []
      @local = {}
      @code = ''
      @methods = {
        puts: lambda { |x| io.puts x }
      }
      @pc = 0
      @labels = {}
    end

    def run
      loop do
        code = @bytecode[@pc]
        @pc += 1
        unless code.class == Fixnum
          case code
            when Array
            case code[0]
              when :putstring, :putobject
              push code[1]
              when :putobject_OP_INT2FIX_O_0_C_
              push 0
              when :putobject_OP_INT2FIX_O_1_C_
              push 1
              when :setlocal_OP__WC__0
              setlocal code[1]
              when :getlocal_OP__WC__0
              getlocal code[1]
              when :opt_send_simple
              opt_send_simple code[1]
              when :opt_plus
              opt_plus code[1]
              when :opt_minus
              opt_minus code[1]
              when :opt_lt
              opt_lt code[1]
              when :opt_le
              opt_le code[1]
              when :opt_gt
              opt_gt code[1]
              when :opt_ge
              opt_ge code[1]
              when :jump
              jump code[1]
              when :branchunless
              branchunless code[1]
              when :branchif
              branchif code[1]
              when :leave
              exit
            end
            when Symbol
            @labels[code] = @pc
          end
        end
      end
    end

    def push(string)
      @stack << string
    end

    def setlocal(number)
      @local[number] = @stack.pop
    end

    def getlocal(number)
      @stack << @local[number]
    end

    def opt_send_simple(args)
      @methods[args[:mid]].call(@stack.pop)
    end

    def opt_plus(args)
      if args[:mid] == :+
        a = @stack.pop
        b = @stack.pop
        @stack << (b + a)
      end
    end

    def opt_minus(args)
      if args[:mid] == :-
        a = @stack.pop
        b = @stack.pop
        @stack << (b - a)
      end
    end

    def opt_lt(args)
      if args[:mid] == :<
        a = @stack.pop
        b = @stack.pop
        @stack << (b < a)
      end
    end

    def opt_le(args)
      if args[:mid] == :'<='
        a = @stack.pop
        b = @stack.pop
        @stack << (b <= a)
      end
    end

    def opt_gt(args)
      if args[:mid] == :>
        a = @stack.pop
        b = @stack.pop
        @stack << (b > a)
      end
    end

    def opt_ge(args)
      if args[:mid] == :'>='
        a = @stack.pop
        b = @stack.pop
        @stack << (b >= a)
      end
    end

    def jump(label)
      @pc = @bytecode.index(label)
    end

    def branchif(label)
      a = @stack.pop
      if a
        @pc = @bytecode.index(label)
      end
    end

    def branchunless(label)
      a = @stack.pop
      unless a
        @pc = @bytecode.index(label)
      end
    end
  end
end