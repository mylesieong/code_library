# Android

### Testing on Android - TestRunners
* What does an AndroidJUnit4 does:
    * User then doesn't need to create an constructor in the test class
    * Neither user needs to extend any TestCase in the test class
    * It will find and run all method marked with @test annotation
* What does a MockitoJUnitRunner does:
    * User doesn't need to initMocks
    * User can replace `Object obj = mock(Object.class)` with an annotation @Mock
    * User can use @InjectMocks
* Basically, these runners only provide convenience to users and which are totally replacable with doing the "old way"
* Thus for example to use Mockito framework in Android Instrumented Test, we can ues either runner and explicitly do the work for another missing runner, 
  or simple use no runners. Here is an example:
  ```java
  @SmallTest
  @RunWith(AndroidJUnit4.class)
  public class MessagingNotificationActionReceiverAndroidTest {
    NotificationHelper mockHelper = mock(NotificationHelper.class);
    @Test
    public void test_mock() {
        when(mockHelper.getIntZero()).thenReturn(3);
        assertTrue(mockHelper.getIntZero() == 3);
    }
  }
  ```

### Testing on Android - Unit test
* How to setup a unit test:
    1. Gradle dependencies:
    ```groovy
    dependencies {
            testImplementation 'junit:junit:4.12'// Required -- JUnit 4 framework
            testImplementation 'org.mockito:mockito-core:1.10.19'// Optional -- Mockito framework
    }
    ```
    1. Declare the POJO test and its that simple:
    ```java
    public class EmailValidatorTest {
            @Test public void emailValidator_CorrectEmailSimple_ReturnsTrue() { assertThat(EmailValidator.isValidEmail("name@email.com"), is(true)); }
    }
    ```
    1. (Optional) To use mockito, you need to put @RunWith(MockitoJUnitRunner.class) and also add unitTests.returnDefaultValues = true into block build.gradle::android::testOptions

### Testing on Android - Instrumented Test
* How to setup an instrumented test:
    1. Gradle dependencies:
    ```groovy
    dependencies {
            androidTestImplementation 'com.android.support:support-annotations:27.1.1' // Contains @Test @Before these stuffs
            androidTestImplementation 'com.android.support.test:runner:1.0.2' //Contains the AndroidJUnitRunner
            androidTestImplementation 'com.android.support.test:rules:1.0.2' //Contains ActivityTestRule, ServiceTestRule etc.(they replaced ActivityInstrumentationTestCase2/ ServiceTestCase)
            androidTestImplementation 'org.hamcrest:hamcrest-library:1.3' // Optional -- Hamcrest library
            androidTestImplementation 'com.android.support.test.espresso:espresso-core:3.0.2'// Optional -- UI testing with Espresso
            androidTestImplementation 'com.android.support.test.uiautomator:uiautomator-v18:2.1.3'// Optional -- UI testing with UI Automator
    }
    ```
    1. Declare using AndroidJUnitRunner (do below in module-level build.gradle):
    ```groovy    
    android {
            defaultConfig {
                testInstrumentationRunner "android.support.test.runner.AndroidJUnitRunner"
            }
    }
    ```
    1. Declare your test class with @RunWith(AndroidJUnit4.class) and use test annotations to indicate tests
    1. Create empty class defining the test suite, see [here](https://developer.android.com/training/testing/unit-testing/instrumented-unit-tests#test-suites) for how to template.
* To write an instrumented test for test a Activity:
    1. import dependencies of instrumented test
    1. declared to use AndroidJUnitRunner
    1. Build testClass with @RunWith and @Test (and others)
    1. Use ActivityTestRule in it (so no needs to extend any testcases parent classes)
* To write an instrumented test for test a Service:
    1. import dependencies of instrumented test
    1. declared to use AndroidJUnitRunner
    1. Build testClass with @RunWith and @Test (and others)
    1. Use ServiceTestRule in it (so no needs to extend any testcases parent classes)
* To write an espresso test for test a Activity:
    1. import dependencies of instrumented test
    1. declared to use AndroidJUnitRunner
    1. Build testClass with @RunWith and @Test (and others)
    1. Use ActivityTestRule in it (so no needs to extend any testcases parent classes)
    1. Use espresso APIs like `onView()`, `withId()`, `perform()`, `check()` and etc.
* @SmallTest vs @MediumTest vs @LargeTest:
    * All three annotation are just for instrumented tests
    * When annotation added, AndroidJUnitRunner will control system resource and total time allowance so to achieve 
      to finish small test in max 60s, medium in max300s and large in max 900+s
    * See [here](https://testing.googleblog.com/2010/12/test-sizes.html)
* To ues Mockito on Android Instrumented Test, we need to add dex-maker dependencies: 
    ```groovy
    androidTestImplementation 'com.google.dexmaker:dexmaker-mockito:' + UT_DEXMAKER_VERSION
    androidTestImplementation 'com.google.dexmaker:dexmaker:' + UT_DEXMAKER_VERSION
    ```
* Dexmaker only works with Mockito framework version 1.x (not compatible with 2.x - 2018-06-01)
* PowerMock can only work on JVM, not on Dalvik even with Dexmaker

### Testing on Android - Overview
* Small test aka Unit tests - 70%
    * Is NOT a instrumented test
    * We can use basic JUnit but without android.jar's power (so classes like android.text.TextUtils won't work as expect)
    * Can use mockito
    * Just on jvm
    * Robolectric executes testing-friendly, jvm-based logic stubs that emulate the android framework. 
* Medium test aka Integration tests - 20%
    * Is a instrumented test
    * e.g Tests for services, content providers, activities
    * Firebase test lab can help on testing it with different combination of screen size and hw config
* Large test aka UI tests - 10%
    * Is a instrumented test
    * We use AndroidJUnitRunner to run instrumented test. It loads (1) test package onto test devices, (2) runs tests and (3) reports results
    * AndroidJUnitRunner supports JUnit4 Rules, Espresso, UI Automator and Android Test Orchestrator
* [Test samples](https://github.com/googlesamples/android-testing)
* Other libraries to make testing easilier are: mockito, powermock, Hamcrest(provides flexible assertions using Hamcrest matcher APIs)

### Firebase  
* FCM- Firebase Cloud Messaging, most famous firebase feature, dev setup their firebase key in firebase console and in project
  they import firebase dependencies. Setup rules in firebase console.
* Crashlytics- to monitor crash on release
* Firebase Test Lab- for devs to test medium and large tests

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
