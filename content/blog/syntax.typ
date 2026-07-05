#import "/content/blog.typ": *
#show: main.with(
  title: "Typst Base Syntax and Code Highlight",
  desc: "List of Typst Syntax, for rendering tests.",
  date: "2025-05-27",
  tags: (
    "programming",
    "typst",
  ),
  show-outline: true,
)

==== Raw Blocks

This is an inline raw block `class T`.

This is an inline raw block ```js class T```.

This is a long inline raw block ```js class T {}; class T {}; class T {}; class T {}; class T {}; class T {}; class T {}; class T {}; class T {};```.

Js syntax highlight are handled by syntect:

```js
class T {};
```




python code example:

```python
import math
class Solution:
    def coinChange(self, coins: List[int], amount: int) -> int:

        if amount == 0:
            return 0
        if len(coins) == 1:
            if amount % coins[0] != 0:
                return -1
            return amount // coins[0]


        m = amount
        n = len(coins)

        dp = [ [math.inf]*(m+1) for _ in range(n+1) ]
        for i in range(0, n+1):
            dp[i][0] = 0

        for i in range(0, n+1):
            weight_i = coins[i-1]
            for j in range(1, m+1):
                dp[i][j] = dp[i-1][j]
                if j >= weight_i:
                    dp[i][j] = min(dp[i][j], dp[i][j-weight_i]+1)

        if dp[n][m] == math.inf:
            return -1
        return dp[n][m]
```


$a in RR$

$ a in RR $
