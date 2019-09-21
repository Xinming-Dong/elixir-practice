defmodule Practice.Factor do

    def factor(num) do
        factorize(num, 2, [])
    end

    def factorize(number, factor, result) when rem(number, factor) == 0 do
        [factor|factorize(div(number, factor), factor, result)]
    end

    def factorize(number, factor, result) when number < factor do
        result
    end

    def factorize(number, factor, result) do
        factorize(number, factor + 1, result)
    end
end