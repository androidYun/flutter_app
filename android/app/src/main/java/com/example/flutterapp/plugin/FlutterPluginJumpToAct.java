package com.example.flutterapp.plugin;

import android.app.Activity;
import android.content.Intent;

import com.example.flutterapp.ui.OneActivity;

import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;

/**
 * @Author Li Gui Yun
 * @date 2018年12月23日16:24
 * @email guiyun.li@aihuishou.com
 * @ClassName:
 **/
public class FlutterPluginJumpToAct implements MethodChannel.MethodCallHandler, EventChannel.StreamHandler {

    public static String CHANNEL = "com.example.flutterapp.plugin";

    static MethodChannel channel;

    static EventChannel eventChannel;

    private Activity activity;

    public FlutterPluginJumpToAct(Activity activity) {
        this.activity = activity;
    }

    public static void registerWith(PluginRegistry.Registrar registrar) {
        channel = new MethodChannel(registrar.messenger(), CHANNEL);
        eventChannel = new EventChannel(registrar.messenger(), CHANNEL);
        FlutterPluginJumpToAct instance = new FlutterPluginJumpToAct(registrar.activity());
        //setMethodCallHandler在此通道上接收方法调用的回调
        channel.setMethodCallHandler(instance);
    }

    @Override
    public void onMethodCall(MethodCall call, MethodChannel.Result result) {
        //通过MethodCall可以获取参数和方法名，然后再寻找对应的平台业务，本案例做了2个跳转的业务

        //接收来自flutter的指令oneAct
        if (call.method.equals("oneAct")) {

            //跳转到指定Activity
            String name = call.argument("name");
            String age = call.argument("age");
            Intent intent = new Intent(activity, OneActivity.class);
            intent.putExtra("name", name);
            intent.putExtra("age", age);
            activity.startActivity(intent);

            //返回给flutter的参数
            result.success("success");
        }
        //接收来自flutter的指令twoAct
        else if (call.method.equals("twoAct")) {

            //解析参数
            String text = call.argument("flutter");

            //带参数跳转到指定Activity
            Intent intent = new Intent(activity, OneActivity.class);
            activity.startActivity(intent);

            //返回给flutter的参数
            result.success("success");
        } else if (call.method.equals("listen")) {

        } else {
            result.notImplemented();
        }
    }

    @Override
    public void onListen(Object o, EventChannel.EventSink eventSink) {
        System.out.println("数据来了");
    }

    @Override
    public void onCancel(Object o) {
        System.out.println("取消数据");
    }

    public void send() {
        eventChannel.setStreamHandler(this);
    }
}
