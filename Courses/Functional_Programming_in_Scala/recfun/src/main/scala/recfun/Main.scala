package recfun

object Main {
  def main(args: Array[String]) = {
  }

  /**
   * Exercise 1
   */
    def pascal(c: Int, r: Int): Int = {
      if (c < 0) 0 else
      if (r < 0) 0 else
      if (c == 0 && r == 0) 1 else
      pascal(c, r - 1) + pascal(c - 1, r - 1)
    }
  
  /**
   * Exercise 2
   */
    def balance(chars: List[Char]): Boolean = {
      def brackets(chars: List[Char], num: Integer): Boolean = {
        if (chars.isEmpty) 
          num == 0
        else {
          val next: Integer = chars.head match {
            case '(' => num + 1
            case ')' => num - 1
            case _   => num
          }

          if (next < 0) false else brackets(chars.tail, next)
        }
      }

      brackets(chars, 0)
    }
  
  /**
   * Exercise 3
   */
    def countChange(money: Int, coins: List[Int]): Int = {
      if (money == 0)
        1
      else if (money < 0 || coins.isEmpty)
        0
      else
        countChange(money - coins.head, coins) + countChange(money, coins.tail)
    }
  }
