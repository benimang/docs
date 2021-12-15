# decorator 装饰器


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

``` py hl_lines="3 12 14"
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



## Examples



### @cache

官方提供的方法，函数调用的结果将缓存起来，下次再调用则使用缓存直接返回

``` py hl_lines="1 3"
from functools import cache

@cache
def factorial(n: int):
    return n * factorial(n - 1) if n else 1
```


### @cached_property

官方提供的方法，针对类成员函数，相当于是带缓存版本 `@property`

``` py hl_lines="1 8"
from functools import cached_property

class AClass:

    def __init__(self):
        self.data = (1, 2)

    @cached_property
    def first_value(self):
        return self.data[0]
```


### 异步超时

这个可以指定 `async` 函数的超时时间

``` py hl_lines="6-13 15"
import asyncio
from functools import wraps
from typing import Any
from async_timeout import timeout

def asyncTimeout(waitSeconds: float):
    def fun(func: Any):
        @wraps(func)
        async def wrapper(*args: Any, **kwargs: Any):
            async with timeout(waitSeconds):
                return await func(*args, **kwargs)
        return wrapper
    return fun

@asyncTimeout(2)
async def myfun():    
    await asyncio.sleep(3)
```

!!! warning
    这里抛出的异常是 `asyncio.CancelledError` 