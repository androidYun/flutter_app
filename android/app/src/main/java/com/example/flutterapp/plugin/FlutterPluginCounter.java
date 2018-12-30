package com.example.flutterapp.plugin;

import android.app.Activity;
import android.util.Log;

import java.util.concurrent.TimeUnit;

import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.PluginRegistry;

/**
 * @Author Li Gui Yun
 * @date 2018年12月23日16:57
 * @email guiyun.li@aihuishou.com
 * @ClassName:
 **/
public class FlutterPluginCounter implements EventChannel.StreamHandler {
    public static String CHANNEL = "com.example.flutterapp.FlutterPluginCounter";

    static EventChannel channel;

    private Activity activity;

    public FlutterPluginCounter(Activity activity) {
        this.activity = activity;
    }

    public static void registerWith(PluginRegistry.Registrar registrar) {
        channel = new EventChannel(registrar.messenger(), CHANNEL);
        FlutterPluginCounter instance = new FlutterPluginCounter(registrar.activity());
        channel.setStreamHandler(instance);
    }

    @Override
    public void onListen(Object o, final EventChannel.EventSink eventSink) {
        eventSink.success("数据好了");
    }

    @Override
    public void onCancel(Object o) {
        Log.i("FlutterPluginCounter", "FlutterPluginCounter:onCancel");
    }

    public void send(){}
}
