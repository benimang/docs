# 装饰器 decorator



## 装饰器无参数

``` py
from typing import Any

def decorator_a(func: Any):
    def wraper(*parList: Any, **parDict: Any):
        print("a.before ...")
        result = func(*parList, **parDict)
        print("a.after ...")
        return result
    return wraper

@decorator_a
def myfun_a():
    print("myfun_a")
```

!!! tips
    这里装饰器的逻辑等价于 `#!py myfun_a = decorator_a(myfun_a)`

!!! warning
    封装后 `#!py myfun_a.__name__` 发生了改变，如果想封装后不改这个名字可以用 [wraps](#functoolswraps)



## 装饰器有参数

``` py
from typing import Any

def decorator_b(value: str):
    def decorator_b1(func: Any):
        def wraper(*parList: Any, **parDict: Any):
            print("b.before ...")
            print(f"b value is {value}")
            result = func(*parList, **parDict)
            print("b.after ...")
            return result
        return wraper
    return decorator_b1

@decorator_b("xxx")
def myfun_b():
    print("myfun_b")
```

!!! tips
    这里装饰器的逻辑等价于 `#!py myfun_b = decorator_b("xxx")(myfun_b)` 相当于封装再封装

!!! warning
    封装后 `#!py myfun_b.__name__` 发生了改变，如果想封装后不改这个名字可以用 [wraps](#functoolswraps)


## 成员函数及叠加使用

``` py hl_lines="24-25"
from typing import Any

def decorator_a(func: Any):
    def wraper(*parList: Any, **parDict: Any):
        print("a.before ...")
        result = func(*parList, **parDict)
        print("a.after ...")
        return result
    return wraper

def decorator_b(value: str):
    def decorator_b1(func: Any):
        def wraper(*parList: Any, **parDict: Any):
            print("b.before ...")
            print(f"b value is {value}")
            result = func(*parList, **parDict)
            print("b.after ...")
            return result
        return wraper
    return decorator_b1

class AClass():

    @decorator_a
    @decorator_b("mmm")
    def method_b(self):
        print("AClass.method_b is called")
```

!!! tips
    执行顺序是 `a.before` -> `b.before` -> `method_b` -> `b.after` -> `a.after`



## @functools.wraps

官方提供的方法，通过这个包装后，函数的名称不会改变

``` py hl_lines="1 5"
from functools import wraps
from typing import Any

def decorator_a(func: Any):
    @wraps(func)
    def wraper(*parList: Any, **parDict: Any):
        print("a.before ...")
        result = func(*parList, **parDict)
        print("a.after ...")
        return result
    return wraper

@decorator_a
def myfun_a():
    print("myfun_a")
```


