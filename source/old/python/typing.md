# typing


## TypeVar


### 类型

``` py linenums="1"
from typing import Type


class AClass():

    @classmethod
    def myfunc(cls):
        pass

    def xx(self):
        print('xxxxdd')


def myfun(cls: Type[AClass]):
    xx = cls()
    xx.xx()


def myfun2(cls: Type[object]):
    pass


myfun(AClass)
```



### 泛型使用

``` py linenums="1"
from typing import TypeVar

TestType = TypeVar('TestType', int, str)

def myfun(aa: TestType, bb: TestType) -> TestType:
    return aa + bb

myfun('a', 'b')  # ab
myfun(123, 456)  # 579
```

### decorator 类型定义

``` py linenums="1"
from typing import TypeVar, Callable, Any, Coroutine

WrappedFunc = TypeVar("WrappedFunc", bound=Callable[..., object])
WrappedAsyncFunc = TypeVar("WrappedAsyncFunc", bound=Callable[..., Coroutine[Any, Any, object]])
```

!!! tips
    [详细使用方法参考 `decorator` 实现](decorator.md#typing-类型返回)