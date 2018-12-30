package com.example.flutterapp;

import android.os.Bundle;

import com.example.flutterapp.plugin.FlutterPluginCounter;
import com.example.flutterapp.plugin.FlutterPluginJumpToAct;

import io.flutter.app.FlutterActivity;
import io.flutter.app.FlutterPluginRegistry;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        registerCustomPlugin(this);
    }

    private void registerCustomPlugin(PluginRegistry pluginRegistry) {
        GeneratedPluginRegistrant.registerWith(this);
        FlutterPluginJumpToAct.registerWith(pluginRegistry.registrarFor(FlutterPluginJumpToAct.CHANNEL));
    }

}

