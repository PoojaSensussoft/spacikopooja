package com.example.spacikopooja;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.widget.Toast;

public class NetworkChangeReceiver extends BroadcastReceiver {

    @Override
    public void onReceive(final Context context, final Intent intent) {
        if (checkInternet(context)) {
        }
    }

    boolean checkInternet(Context context) {
        ServiceManager serviceManager = new ServiceManager(context);
        if (serviceManager.isNetworkAvailable()) {
            Toast.makeText(context, "Connected", Toast.LENGTH_SHORT).show();
            return true;
        } else {
            Toast.makeText(context, "Not Connected", Toast.LENGTH_SHORT).show();
            return false;
        }
    }
}
