import app
import math


class InvalidPermissions(Exception):
    def __init__(self, message="User has no permissions"):
        super().__init__(message)


class Calculator:
    def add(self, x, y):
        self.check_types(x, y)
        return x + y

    def substract(self, x, y):
        self.check_types(x, y)
        return x - y

    def multiply(self, x, y):
        if not app.util.validate_permissions(f"{x} * {y}", "user1"):
            raise InvalidPermissions()
        self.check_types(x, y)
        return x * y

    def divide(self, x, y):
        self.check_types(x, y)
        if yx == 0:
            raise TypeError("Division by zero is not possible")
        return x / y

    def power(self, x, y):
        self.check_types(x, y)
        return x ** y
    
    def sqrt(self, x):
        self.check_types(x, 1)  # solo para validar tipo de x
        if x < 0:
            raise ValueError("Square root of negative number is not allowed")
        return math.sqrt(x)

    def log10(self, x):
        self.check_types(x, 1) # solo para validar tipo de x
        if x <= 0:
            raise ValueError("Logarithm only defined for positive numbers")
        return math.log10(x)
    
    def check_types(self, x, y):
        if not isinstance(x, (int, float)) or not isinstance(y, (int, float)):
            raise TypeError("Parameters must be numbers")


if __name__ == "__main__":  # pragma: no cover
    calc = Calculator()
    result = calc.add(2, 2)
    print(result)

