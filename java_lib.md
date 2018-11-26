# Java

## Exception handling
* Throwable has 2 impl: Error and Exception, Exception has RuntimeException and other impl
* UncheckedException: refers to Error(subclasses) & RuntimeException(subclasses) and it is not required to be either declared as throwing method or trycatch
* CheckedException: refers to Exception's subclasses except RuntimeException, theys are all required to be handle. e.g. DataFormatException, RemoteException and etc.

## Mockito
* Spy vs. Mock
    * Spy is used on an instance, while mock is used on a class.
    * We stub mock's behavior with: `when(mockee.foo()).thenReturn("bar");`
    * We stub spy's behavior with: `doReturn("bar").when(mockee).foo();` 
    * The reason we can't use when...thenReturn in spies is because spy actually do the job in its real object. What doReturn do is just stub the result, but what the mockee's real object does still been done internally.
* Set the argument in a mock method and generalize the argument with anyInt()/ anyString()/ any(Foo.class)
`when(mockedMap.get(anyString())).thenReturn("foobar");`
* Set private field with WhiteBox
```java
import org.mockito.internal.util.reflection.Whitebox;
...
Whitebox.setInternalState(testee, "mConnected", true);
```
* Stub a void method like List.clear(): `doNothing().when(mockList).clear();`
* __PowerMock__ is extention that support both EasyMock and Mockito (these are 2 diff mocking framework) and so far I only need it for its *static method stubbing feature*. The simple step to use it(e.g. Stub the Math.random()):
    1. Replace @RunWith(MockitoUnitRunner.class) to @RunWith(PowerMockRunner.class) and it won't affect previous wriiten test.
    1. Add @PrepareForTest(Math.class)
    1. PowerMockito.mockStatic(Math.class); 
    1. Mockito.when(Math.random()).thenReturn(1.1);
    1. assertTrue(Math.random()==1.1);

