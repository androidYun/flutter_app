package com.example.flutterapp.ui;

import android.app.Activity;
import android.os.Bundle;
import android.view.View;
import android.widget.TextView;

import com.example.flutterapp.R;
import com.example.flutterapp.plugin.FlutterPluginCounter;
import com.example.flutterapp.plugin.FlutterPluginJumpToAct;

import org.jetbrains.annotations.Nullable;

import io.flutter.app.FlutterActivity;

/**
 * @Author Li Gui Yun
 * @date 2018年12月23日16:29
 * @email guiyun.li@aihuishou.com
 * @ClassName:
 **/
public class OneActivity extends FlutterActivity {

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_one);
        TextView tvContent = findViewById(R.id.tvContent);
        String name = getIntent().getStringExtra("name");
        String age = getIntent().getStringExtra("age");
        tvContent.setText(name + age);
        tvContent.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                FlutterPluginJumpToAct flutterPluginJumpToAct = new FlutterPluginJumpToAct(OneActivity.this);
                flutterPluginJumpToAct.send();
            }
        });
    }
}
