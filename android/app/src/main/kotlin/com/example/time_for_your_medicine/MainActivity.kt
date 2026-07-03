package com.example.time_for_your_medicine

import android.os.Bundle
import androidx.core.splashscreen.SplashScreen.Companion.installSplashScreen
import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        // Must run before super.onCreate() — see values/styles.xml's
        // LaunchTheme (extends Theme.SplashScreen) for the branding.
        installSplashScreen()
        super.onCreate(savedInstanceState)
    }
}
