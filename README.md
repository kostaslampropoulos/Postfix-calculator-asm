# This is a calculator implemented with the postfix method!

## How it work and how to operate it!

1. First we read the expression from left to right.

2. Push the element in the stack if it is an operand.

3. If the current character is an operatorthen pop the two operands from the stack and then evaluate it.

4. Push back the result of the evaluation.

5. Repeat it till the end of the expression.

6. Checkout examples that are mention below in table.

### Why we need a postfix Calculator:

Infix expressions are readable and solvable by humans. We can easily distinguish the order of operators, and also can use the parenthesis to solve that part first during solving mathematical expressions. But computer cannot differentiate the operators and parenthesis easily, that’s why postfix conversion is needed.Compilers or command editor in computer and some calculators also convert expression to postfix first and then solve those expression to evaluate answer for the same.
