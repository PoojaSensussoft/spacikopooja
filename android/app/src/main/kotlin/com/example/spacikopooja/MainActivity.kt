package com.example.spacikopooja
import android.content.BroadcastReceiver
import android.content.IntentFilter
import android.net.ConnectivityManager
import android.os.Build
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity


open class MainActivity: FlutterActivity() {
    private var mNetworkReceiver: BroadcastReceiver? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        mNetworkReceiver = NetworkChangeReceiver()
        registerNetworkBroadcastForNougat()

//        MethodChannel(flutterEngine!!.dartExecutor.binaryMessenger,"com.example.messages")
//                .setMethodCallHandler{call,result->
//
//                    if(call.method=="startService") {
//                        startService()
//                    }
//                }
    }

    private fun registerNetworkBroadcastForNougat() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
            registerReceiver(mNetworkReceiver, IntentFilter(ConnectivityManager.CONNECTIVITY_ACTION))
        }
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            registerReceiver(mNetworkReceiver, IntentFilter(ConnectivityManager.CONNECTIVITY_ACTION))
        }
    }

    private fun unregisterNetworkChanges() {
        try {
            unregisterReceiver(mNetworkReceiver)
        } catch (e: IllegalArgumentException) {
            e.printStackTrace()
        }
    }

    override fun onDestroy() {
        super.onDestroy()
        unregisterNetworkChanges()
    }

//    lateinit var intent:Any
//    fun startService() {
//        intent=Intent(this,AppService::class.java)
//        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
//            startForegroundService(intent as Intent)
//        }else {
//            startService(intent as Intent)
//        }
//    }
//
//    fun onDestroy() {
//        super.onDestroy()
//        //stopService(intent as Intent)
//    }

}
