package id.flutter.fundamental

import android.annotation.TargetApi
import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.content.Context
import android.os.Build
import android.os.Bundle
import android.util.Log
import android.widget.ImageView
import android.widget.RelativeLayout
import android.widget.RemoteViews
import androidx.core.app.NotificationCompat
import androidx.core.app.NotificationManagerCompat

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    private val CHANNEL = "notification"
    private val NOTIFICATION_ID = 1
    private var notificationIconInitialMargin = 0

//    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
//        super.configureFlutterEngine(flutterEngine)
//
//        // Set up MethodChannel
//        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
//            when (call.method) {
//                "startTask" -> {
//                    val initialProgress = call.argument<Int>("progress") ?: 0
//                    startBackgroundTask(initialProgress)
//                    result.success(null)
//                }
//
//                else -> {
//                    result.notImplemented()
//                }
//            }
//        }
//    }
//
//    override fun onCreate(savedInstanceState: Bundle?) {
//        super.onCreate(savedInstanceState)
//        setContentView(R.layout.notification_layout)
//        startBackgroundTask(0)
//    }

    @TargetApi(Build.VERSION_CODES.JELLY_BEAN_MR1)
    private fun startBackgroundTask(progress: Int) {
        val notificationIcon = findViewById<ImageView>(R.id.notificationIcon)
        if (notificationIcon != null) {
            val params = notificationIcon.layoutParams as? RelativeLayout.LayoutParams
            notificationIconInitialMargin = params?.marginStart ?: 0

            showCustomNotification(progress)
        } else {
            Log.e("MainActivity", "NotificationIcon is null")
        }
    }
//    private fun createRemoteViews(progress: Int): RemoteViews {
//        val remoteViews = RemoteViews(packageName, R.layout.notification_layout)
//
//        // Atur ProgressBar
//        remoteViews.setProgressBar(R.id.notificationProgressBar, 100, progress, false)
//
//        val maxMargin = notificationIconInitialMargin
//        val currentMargin = (progress / 100.0 * maxMargin).toInt()
//        remoteViews.setInt(R.id.notificationIcon, "setMarginStart", currentMargin)
//
//        return remoteViews
//    }

    private fun showCustomNotification(progress: Int) {
        // Create notification layout from XML
        val remoteViews = RemoteViews(packageName, R.layout.notification_layout)

        // Build the notification
        val builder = NotificationCompat.Builder(this, CHANNEL)
            .setSmallIcon(R.mipmap.ic_launcher)
            .setContent(remoteViews)
            .setPriority(NotificationCompat.PRIORITY_HIGH)
            .setVisibility(NotificationCompat.VISIBILITY_PUBLIC)

        // Create the notification channel (for Android O and above)
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val channel = NotificationChannel(CHANNEL, "Your Channel", NotificationManager.IMPORTANCE_HIGH)
            val notificationManager = getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
            notificationManager.createNotificationChannel(channel)
        }

        // Show the notification
        with(NotificationManagerCompat.from(this)) {
            notify(NOTIFICATION_ID, builder.build())
        }

        sendProgressUpdate(progress)
    }

    private fun sendProgressUpdate(progress: Int) {
        val remoteViews = RemoteViews(packageName, R.layout.notification_layout)
        remoteViews.setProgressBar(R.id.notificationProgressBar, 100, progress, false)

        val notificationIconMargin =
            notificationIconInitialMargin + ((progress / 100.0) * notificationIconInitialMargin).toInt()
        remoteViews.setInt(R.id.notificationIcon, "setMarginStart", notificationIconMargin)

        // Update the notification
        val builder = NotificationCompat.Builder(this, CHANNEL)
            .setSmallIcon(R.mipmap.ic_launcher)
            .setContent(remoteViews)
            .setPriority(NotificationCompat.PRIORITY_HIGH)
            .setVisibility(NotificationCompat.VISIBILITY_PUBLIC)

        with(NotificationManagerCompat.from(this)) {
            notify(NOTIFICATION_ID, builder.build())
        }
    }

    private fun closeNotification() {
        // Close the notification when the task is complete
        with(NotificationManagerCompat.from(this)) {
            cancel(NOTIFICATION_ID)
        }
    }
}
