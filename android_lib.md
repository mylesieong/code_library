# Android

## UI Layout XML

### Use system provided size in Layout XML
'''
android:layout_height="?android:attr/listPreferredItemHeight"
'''

### Use system defined color in Layout XML
'''
android:textColor="@android:color/white"
android:textColor="@color/myColor"  //this is custom color
'''

### Use Custom Drawable Resource in Layout XML
'''
android:background="@drawable/magnitude_circle"
'''

### Center an Element
'''
android:layout_gravity="center_vertical"
android:gravity="center"
'''

### Restrict the lines of a textview
'''
android:ellipsize="end"
android:maxLines="2"
'''

### A <hr> element in ListView 
'''
android:divider="@null"
android:dividerHeight="0dp"
'''

## Service

### Access a external service by intent (By IntentFilter)
'''xml
<service
    android:name=".SomeService"
    android:exported="true">
    <intent-filter>
        <action android:name="StartSomeService" />
    </intent-filter>
<service/>
'''
'''java
Intent intent = new Intent();
intent.setAction("StartSomeService");
// we can use startService or bindService to invoke the onStartCommand or onBind method in the CustomService class
startService(intent); 
bindService(intent, ServiceConnection, int);
'''

### Access an external service by intent (W/O IntentFilter)
'''xml
<service
    android:name=".SomeService"
    android:exported="true" />
'''
'''java
Intent intent = new Intent();
intent.setComponent(new ComponentName(
    "com.thinkincode.someapp",
    "com.thinkincode.someapp.SomeService"));
// we can use startService or bindService to invoke the onStartCommand or onBind method in the CustomService class
startService(intent); 
bindService(intent, ServiceConnection, int);
'''

### General Service
* You need to declare a <Service> in the manifest(and maybe an intent filter)
* You need to override a Service class and return a Binder impl in onBind() so that client can perform the function w/ this Binder
* Binder is the real impl of the aidl function

### AIDL introduction
* AIDL is the only way that another app can access your service.
* Impl steps:
	1. define IMyServiceInterface.aidl file
	1. Impl IMyServiceInterface.Stub class
	1. Create a Service class to expose the IBinder to client
* Sample code for local Service can be found at: https://android.googlesource.com/platform/development/+/master/samples/ApiDemos/src/com/example/android/apis/app/LocalService.java
* Sample code for aidl Service can be found at: https://www.protechtraining.com/blog/post/66 or at summit workstation path: ~/Desktop/ProjectGit/Samples/AIDLDemo
* If you dont tell other how your aidl looks like, they would be able to use it!

### When to use Service by CustomBinder/Messenger/AIDL
* IPC & Concurrent -> AIDL
* IPC & Not Concurrent -> CustomBinder ???
* IPC & Not Concurrent -> Messenger ???

### Diff between startService() and bindService()
startService() can only create 1 instance but bindService() can create multi???
