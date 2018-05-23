# Android

### UI Layout XML

* Use system provided size in Layout XML: `android:layout_height="?android:attr/listPreferredItemHeight"`
* Use system defined color in Layout XML: 
```
android:textColor="@android:color/white"
android:textColor="@color/myColor"  //this is custom color
```

* Use Custom Drawable Resource in Layout XML: `android:background="@drawable/magnitude_circle"`

* Center an Element:
```
android:layout_gravity="center_vertical"
android:gravity="center"
```

* Restrict the lines of a textview:
```
android:ellipsize="end"
android:maxLines="2"
```

* A divider element in ListView:
```
android:divider="@null"
android:dividerHeight="0dp"
```

### AsynTask
* Code snippet:
```java
mytask = new AsynTask<>...{
	@Override
	public void doInBackground(){...}
};
mytask.execute(...);
```

### ListView and RecyclerView
* Easiest way to use ListView, just need to remember override a Adapter and set the adapter to listview and done.
* For RecyclerView, except for creating an adapter, viewHolder is also needed (ref Verison one talk)

### Service
* You need to declare a <Service> in the manifest(and maybe an intent filter)
* You need to override a Service class and return a Binder impl in onBind() so that client can perform the function w/ this Binder
* Binder is the real impl of the aidl function
* When to use Service by CustomBinder/Messenger/AIDL
	* Not IPC & Not Concurrent -> CustomBinder (say your own app using only)
	* IPC & Not Concurrent -> Messenger 
	* IPC & Concurrent -> AIDL
* Diff between startService() and bindService()
	* startService(): service lifecycle can be start and stay forever until stopself or stopservice
	* bindService(): service lifecycle start at first bind and destroy at last unbind
	* if a service both impl the onStartCommand() and onBind(), the lifecycle follows the startService() situaion
* Access a external service by intent (By IntentFilter)
```xml
<service
    android:name=".SomeService"
    android:exported="true">
    <intent-filter>
        <action android:name="StartSomeService" />
    </intent-filter>
<service/>
```
```java
Intent intent = new Intent();
intent.setAction("StartSomeService");
// we can use startService or bindService to invoke the onStartCommand or onBind method in the CustomService class
startService(intent); 
bindService(intent, ServiceConnection, int);
```
* Access an external service by intent (W/O IntentFilter)
```xml
<service
    android:name=".SomeService"
    android:exported="true" />
```
```java
Intent intent = new Intent();
intent.setComponent(new ComponentName(
    "com.thinkincode.someapp",
    "com.thinkincode.someapp.SomeService"));
// we can use startService or bindService to invoke the onStartCommand or onBind method in the CustomService class
startService(intent); 
bindService(intent, ServiceConnection, int);
```

### AIDL
* AIDL should be and should only be used when you need IPC (Interprocess Communicatio) and concurrency at the same time. 
* Impl steps:
	1. define IMyServiceInterface.aidl file
	1. Impl IMyServiceInterface.Stub class
	1. Create a Service class to expose the IBinder to client
* Sample code for local Service can be found at: https://android.googlesource.com/platform/development/+/master/samples/ApiDemos/src/com/example/android/apis/app/LocalService.java
* Sample code for aidl Service can be found at: https://www.protechtraining.com/blog/post/66 or at summit workstation path: ~/Desktop/ProjectGit/Samples/AIDLDemo
* If you dont tell other how your aidl looks like, they won't be able to use it! For example, if you need to use the google donation feature, you need to include the google donation aidl in your project.

### Support Library
* Support Library has many version:
	* support-library-v4: `com.android.support:support-compat:27.1.1`
	* support-library-v7: `com.android.support:appcompat-v7:27.1.1`
	* support-library-v13: `com.android.support:support-v13:27.1.1`
* If you want to use a new feature on an old device so support library comes to resue. Say quick reply notification is after android N but we need it on android K, so we can use v4 support library.
* Set back of support library:
	* It might increase the apk size, but it can be solve by multi-version feature by Proguard
	* It is developed quickly thus not that testible and stable

# Java
*TODO these domains should be moved to seperated markdown*

### Exception handling
* Throwable has 2 impl: Error and Exception, Exception has RuntimeException and other impl
* UncheckedException: refers to Error(subclasses) & RuntimeException(subclasses) and it is not required to be either declared as throwing method or trycatch
* CheckedException: refers to Exception's subclasses except RuntimeException, theys are all required to be handle. e.g. DataFormatException, RemoteException and etc.

### Mockito
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

### RxAndroid
* This is a library to assist async methods. 
* It is based on RxJava, which is a JVM extension for the same purpose.
* In the aspect of user, it uses a simpler pub-sub pattern, or say, an observer pattern(w/o a middle layer in between) 
* Sample code: 
```java
Observable.just("one", "two", "three")
	  .subscribeOn(Schedulers.newThread())
	  .observeOn(AndroidSchedulers.mainThread())
	  .subscribe(/* an Observer*/);
```
