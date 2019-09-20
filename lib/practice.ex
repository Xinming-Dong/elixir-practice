defmodule Practice do
  @moduledoc """
  Practice keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  def double(x) do
    2 * x
  end

  def calc(expr) do
    # This is more complex, delegate to lib/practice/calc.ex
    Practice.Calc.calc(expr)
  end

  def factor(x) do
    # Maybe delegate this too.
    Pracitce.Factor.factors(x)
    
  end

  # TODO: Add a palindrome? function.
  # palindrome function
  # if user entered a word

  def palindrome?(word) when is_binary(word) do
    len = String.length(word)
    if len === 0 do
      true
    else
      # IO.puts word
      reversed = reverse(String.to_charlist(word))
      # IO.puts reversed
      is_palindrome(reversed, word)
    end 
  end

  def palindrome?() do
    true
  end

  # def palindrome?(word) when is_integer(word) do
  #   IO.puts word
  #   reversed = reverse(Integer.to_charlist(word))
  #   IO.puts reversed
  #   is_palindrome(reversed, word)
  # end

  # define reverse function
  defp reverse([head|tail]) do
    reversed = [head]
    reverse(reversed, tail)
  end

  defp reverse(reversed, [head|tail]) do
    reverse([head] ++ reversed, tail)
  end

  defp reverse(reversed, []) do
    List.to_string reversed
  end

  # define is_palindrome function
  defp is_palindrome(reversed, word) when reversed == word do
    true
  end

  defp is_palindrome(reversed, word) when reversed != word do
    false
  end


end
