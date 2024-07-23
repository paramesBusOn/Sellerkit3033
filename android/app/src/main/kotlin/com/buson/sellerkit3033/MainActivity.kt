package com.busondigitalservice.sellerkit3033
import android.annotation.TargetApi
import android.content.pm.PackageManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.android.FlutterFragmentActivity;
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.plugin.common.MethodChannel
import android.os.Bundle
import io.flutter.plugin.common.MethodCall
import android.provider.ContactsContract
import android.content.Intent
import android.content.Context
import android.os.Build
import android.telephony.TelephonyManager


class MainActivity: FlutterActivity() {
    
    private val CHANNEL = "app_availability"
    private lateinit var appContext: Context // Declare appContext as a class-level variable
    
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        GeneratedPluginRegistrant.registerWith(flutterEngine)
        val mobileNetworkInfo = MobileNetworkInfo(applicationContext)
        val channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "your_channel_name")
        channel.setMethodCallHandler { call, result ->
            if (call.method == "getMobileNetworkName") {
                result.success(mobileNetworkInfo.getMobileNetworkName())
            } else {
                result.notImplemented()
            }
        }

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
                call, result ->


            when (call.method) {
            "isAppInstalled" -> {
                val packageName = call.arguments.toString()
                val isInstalled = isAppInstalled("com.busondigitalservice.sellerkit3033")
                result.success(isInstalled)
            }
            "launchApp" -> {
                val packageName = call.arguments.toString()
                launchApp(packageName)
                result.success(null)
            }
            "openCreateContact" -> {
                val arguments = call.arguments as Map<String, String>
                val name = arguments["name"] ?: ""
                val phone = arguments["phone"] ?: ""
                openCreateContact(name, phone)
                result.success(null)
            }
            "openAppInBackground" -> {
                val packageName = call.arguments.toString()
                openAppInBackground(packageName)
                result.success(null)
            }
            else -> {
                result.notImplemented()
            }
            }
        }

    }



    private fun isAppInstalled(packageName: String): Boolean {
        return try {
            packageManager.getPackageInfo(packageName, PackageManager.GET_ACTIVITIES)

            true
        } catch (e: PackageManager.NameNotFoundException) {

            false
        }
    }
    private fun launchApp(packageName: String) {
        val intent = packageManager.getLaunchIntentForPackage(packageName)
        if (intent != null) {
            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
            startActivity(intent)
        } else {
            // App not found, handle error or show a message
        }
    }
    
    private fun openCreateContact(name: String, phone: String) {
        // Create a new Intent to open the Contacts app with a pre-filled contact form
        val intent = Intent(Intent.ACTION_INSERT)
        intent.type = ContactsContract.Contacts.CONTENT_TYPE

        // Set the contact fields using the data provided by the Flutter app
        intent.putExtra(ContactsContract.Intents.Insert.NAME, name)
        intent.putExtra(ContactsContract.Intents.Insert.PHONE, phone)

        // Launch the Contacts app with the pre-filled contact form
        startActivity(intent)
    }

    @TargetApi(Build.VERSION_CODES.CUPCAKE)
    private fun openAppInBackground(packageName: String) {
//        val context: Context = applicationContext
        val intent = appContext.packageManager.getLaunchIntentForPackage(packageName)
        if (intent != null) {
            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
            appContext.startActivity(intent)
        } else {
            // Handle case where app is not installed or launch intent is not available
        }
    }
}
