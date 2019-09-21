defmodule Practice.Calc do
  def parse_float(text) do
    {num, _} = Float.parse(text)
    num
  end

  def calc(expr) do
    # This should handle +,-,*,/ with order of operations,
    # but doesn't need to handle parens.
    
    exp_list = String.split(expr, ~r/\s+/)
    exp_taged = tag_tokens(exp_list)
    # post = to_postfix(exp_taged, [], [])
    
    exp_postfix = Enum.reverse(to_postfix(exp_taged, [], []))
    # IO.inspect exp_postfix
    exp_prefix = to_prefix(exp_postfix, [])
    # IO.inspect exp_prefix


    # |> hd
    # |> parse_float
    # |> :math.sqrt()

    # Hint:
    # expr
    # |> split
    # |> tag_tokens  (e.g. [+, 1] => [{:op, "+"}, {:num, 1.0}]
    # |> convert to postfix
    # |> reverse to prefix
    # |> evaluate as a stack calculator using pattern matching
  end

  def tag_tokens([head|tail]) when head == "+" or head == "-" or head == "*" or head == "/" do
    if tail == [] do
      [{:op, head}]
    else
      [{:op, head}|tag_tokens(tail)]
    end
  end
  
  def tag_tokens([head|tail]) do
    if tail == [] do 
      [{:num, parse_float(head)}]
    else
      [{:num, parse_float(head)}|tag_tokens(tail)]
    end
  end

  # helper functions
  def get_level(val) when val == "+" or val == "-" do
    1
  end
  def get_level(val) when val == "*" or val == "/" do
    0
  end
  def push(val1, val2) do
    [val1|val2]
  end

  # to postfix
  def to_postfix([{key, val}|tail], op_stack, result_stack) when key == :"num" do
    to_postfix(tail, op_stack, [{key, val}|result_stack])
  end
  def to_postfix([{key, val}|tail], [], result) when key == :"op" do
    to_postfix(tail, [{key, val}], result)
  end
  def to_postfix([{key1, val1}|tail1], [{key2, val2}|tail2], result) when key1 == :"op" do
    if get_level(val1) <= get_level(val2) do
      to_postfix(tail1, push({key1, val1}, [{key2, val2}|tail2]), result)
    else
      to_postfix(tail1, [{key1, val1}|tail2], [{key2, val2}|result])
    end
  end
  def to_postfix([], [head|tail], result) do
    to_postfix([], tail, [head|result])
  end
  def to_postfix([], [], result) do
    result
  end

  # to prefix
  # def to_prefix([], [{ke_y, result}]) do
  #   result
  # end
  # def to_prefix([{key, val}|tail], result) when key == :"num" do
  #   to_prefix(tail, [{key, val}|result])
  # end
  # def to_prefix([{key, val}|tail], result) when key == :"op" do
  #   to_prefix([{key, val}|tail], result, 1)
  # end
  # def to_prefix([{key, val}|tail], [{key_op1, val_op1}|tail_op1], 1) do
  #   to_prefix([{key, val}|tail], tail_op1, val_op1, 2)
  # end
  # def to_prefix([{key, val}|tail], [{key_op2, val_op2}|tail_op2], val_op1, 2) do
  #   str = to_string(val)<>to_string(val_op2)<>to_string(val_op1)
  #   IO.puts str
  #   to_prefix(tail, [{:num, str}|tail_op2])
  # end

  def to_prefix([], [{ke_y, result}]) do
    result
  end
  def to_prefix([{key, val}|tail], result) when key == :"num" do
    to_prefix(tail, [{key, val}|result])
  end
  def to_prefix([{key, val}|tail], result) when key == :"op" do
    to_prefix([{key, val}|tail], result, 1)
  end
  def to_prefix([{key, val}|tail], [head_op1|tail_op1], 1) do
    to_prefix([{key, val}|tail], tail_op1, head_op1, 2)
  end
  def to_prefix([head|tail], [head_op2|tail_op2], head_op1, 2) do
    # push({key1, val1}, [{key2, val2}|tail2])
    # con1 = [{key, val}|head_op2]
    # con2 = [con1|head_op1]
    operand = calculate(head_op1, head_op2, head)
    to_prefix(tail, [{:num, operand}|tail_op2])
  end

  # calculate
  def calculate({key_op1, val_op1}, {key_op2, val_op2}, {key, val}) when val == "+" do
    val_op2 + val_op1
  end
  def calculate({key_op1, val_op1}, {key_op2, val_op2}, {key, val}) when val == "-" do
    val_op2 - val_op1
  end
  def calculate({key_op1, val_op1}, {key_op2, val_op2}, {key, val}) when val == "*" do
    val_op2 * val_op1
  end
  def calculate({key_op1, val_op1}, {key_op2, val_op2}, {key, val}) when val == "/" do
    val_op2 / val_op1
  end
end
