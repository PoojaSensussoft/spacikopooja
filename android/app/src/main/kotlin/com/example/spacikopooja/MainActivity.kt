package com.example.spacikopooja
import android.content.*
import android.os.BatteryManager
import android.os.Build
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel


open class MainActivity: FlutterActivity() {
    private var mNetworkReceiver: BroadcastReceiver? = null

    private val sharedText: String? = null
    private val _CHANNEL = "app.channel.shared.data"


//    override fun onCreate(savedInstanceState: Bundle?) {
//        super.onCreate(savedInstanceState)
//
//        mNetworkReceiver = NetworkChangeReceiver()
//        registerNetworkBroadcastForNougat()
//    }
//
//    private fun registerNetworkBroadcastForNougat() {
//        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
//            registerReceiver(mNetworkReceiver, IntentFilter(ConnectivityManager.CONNECTIVITY_ACTION))
//        }
//        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
//            registerReceiver(mNetworkReceiver, IntentFilter(ConnectivityManager.CONNECTIVITY_ACTION))
//        }
//    }
//
//    private fun unregisterNetworkChanges() {
//        try {
//            unregisterReceiver(mNetworkReceiver)
//        } catch (e: IllegalArgumentException) {
//            e.printStackTrace()
//        }
//    }
//
//    override fun onDestroy() {
//        super.onDestroy()
//        unregisterNetworkChanges()
//    }


    private val CHANNEL = "samples.flutter.dev/battery"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "getBatteryLevel") {
                val batteryLevel = getBatteryLevel()

                if (batteryLevel != -1) {
                    result.success(batteryLevel)
                } else {
                    result.error("UNAVAILABLE", "Battery level not available.", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }


    private fun getBatteryLevel(): Int {
        val batteryLevel: Int
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            val batteryManager = getSystemService(Context.BATTERY_SERVICE) as BatteryManager
            batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
        } else {
            val intent = ContextWrapper(applicationContext).registerReceiver(null, IntentFilter(Intent.ACTION_BATTERY_CHANGED))
            batteryLevel = intent!!.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100 / intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1)
        }

        return batteryLevel
    }
}
