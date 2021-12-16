# typing


## TypeVar

### 泛型使用

``` py
from typing import TypeVar

TestType = TypeVar('TestType', int, str)

def myfun(aa: TestType, bb: TestType) -> TestType:
    return aa + bb

myfun('a', 'b')  # ab
myfun(123, 456)  # 579
```

### decorator 类型定义

``` py
from typing import TypeVar, Callable, Any, Coroutine

WrappedFunc = TypeVar("WrappedFunc", bound=Callable[..., object])
WrappedAsyncFunc = TypeVar("WrappedAsyncFunc", bound=Callable[..., Coroutine[Any, Any, object]])
```

!!! tips
    [详细使用方法参考 `decorator` 实现](decorator.md#typing-类型返回)