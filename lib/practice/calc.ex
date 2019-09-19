defmodule Practice.Calc do
  def parse_float(text) do
    {num, _} = Float.parse(text)
    num
  end

  def calc(expr) do
    # This should handle +,-,*,/ with order of operations,
    # but doesn't need to handle parens.
    
    # IO.puts(String.split(expr, ~r/\s+/))
    exp_list = String.split(expr, ~r/\s+/)
    cur = []
    exp_taged = tag_tokens(exp_list)
    IO.inspect exp_list
    # IO.puts exp_taged

    # num_stack=[]
    # op_stack=[]
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

  def tag_tokens(x) when x == "+" do
    IO.puts x
    {:o1, x}
  end

  def tag_tokens(x) when x == "-" do
    {:o1, x}
  end

  def tag_tokens(x) when x == "*" do
    {:o0, x}
  end

  def tag_tokens(x) when x == "/" do
    {:o0, x}
  end
  
  def tag_tokens(x) do
    {:num, parse_float(x)}
  end
end
