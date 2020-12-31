package com.example.spacikopooja

import android.app.Application
import android.app.NotificationChannel
import android.app.NotificationManager
import android.content.Context
import android.os.Build
import io.flutter.app.FlutterApplication
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugin.common.PluginRegistry.PluginRegistrantCallback
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.plugins.firebasemessaging.FlutterFirebaseMessagingService

class Application : FlutterApplication(), PluginRegistrantCallback {

    override fun onCreate() {
        super.onCreate()
        FlutterFirebaseMessagingService.setPluginRegistrant(this);
    }

    override fun registerWith(registry: PluginRegistry?) {
        io.flutter.plugins.firebasemessaging.FirebaseMessagingPlugin.registerWith(registry?.registrarFor("io.flutter.plugins.firebasemessaging.FirebaseMessagingPlugin"));
    }
}

//class App: FlutterApplication(), PluginRegistrantCallback {
//    fun onCreate() {
//        super.onCreate()
//        FlutterFirebaseMessagingService.setPluginRegistrant(this)
//
//        if(Build.VERSION.SDK_INT>=Build.VERSION_CODES.O) {
//            val notificationChannel= NotificationChannel("msgs","msgs", NotificationManager.IMPORTANCE_LOW)
//            val notificationManager=getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
//            notificationManager.createNotificationChannel(notificationChannel)
//        }
//    }
//
//    fun registerWith(registry: PluginRegistry?) {
//        io.flutter.plugins.firebasemessaging.FirebaseMessagingPlugin.registerWith(registry.registrarFor("io.flutter.plugins.firebasemessaging.FirebaseMessagingPlugin")); io.flutter.plugins.firebasemessaging.FirebaseMessagingPlugin.registerWith(registry.registrarFor("io.flutter.plugins.firebasemessaging.FirebaseMessagingPlugin"));
//    }
//}