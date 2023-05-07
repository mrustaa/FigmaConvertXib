package mrusta.FigmaConvertAndroidXml.ui;

import mrusta.FigmaConvertAndroidXml.R;

import androidx.appcompat.app.AppCompatActivity;
import androidx.constraintlayout.widget.ConstraintLayout;

import android.graphics.Color;
import android.os.Bundle;
import android.widget.LinearLayout;
import android.widget.LinearLayout.LayoutParams;
import android.widget.Button;

import static mrusta.FigmaConvertAndroidXml.R.layout.result_android;

public class MainActivity extends AppCompatActivity {

    @Override protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(result_android);

        ConstraintLayout main = findViewById(R.id.main);
        main.setBackgroundColor(Color.GRAY);
    }
}