package com.example.spacikopooja

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.widget.Toast

class NetworkChangeReceiver : BroadcastReceiver() {
    @Override
    override fun onReceive(context: Context?, intent: Intent?) {
        if (checkInternet(context)) {
        }
    }

    fun checkInternet(context: Context?): Boolean {
        val serviceManager = ServiceManager(context!!)
        return if (serviceManager.isNetworkAvailable) {
            Toast.makeText(context, "Connected", Toast.LENGTH_SHORT).show()
            true
        } else {
            Toast.makeText(context, "Not Connected", Toast.LENGTH_SHORT).show()
            false
        }
    }
}