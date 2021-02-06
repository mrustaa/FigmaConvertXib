package mrusta.FigmaConvertAndroidXml.framework.recyclerAdapter.Interface;

import mrusta.FigmaConvertAndroidXml.framework.recyclerAdapter.RecyclerAdapter;

import androidx.appcompat.app.AppCompatActivity;
import android.os.Bundle;

import mrusta.FigmaConvertAndroidXml.R;

import androidx.recyclerview.widget.DividerItemDecoration;
import androidx.recyclerview.widget.RecyclerView;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import mrusta.FigmaConvertAndroidXml.ui.cell.ButtonCell;
import mrusta.FigmaConvertAndroidXml.ui.cell.ImageCell;
import mrusta.FigmaConvertAndroidXml.ui.cell.TextCell;


public class RecyclerAdapterActivity extends AppCompatActivity {

    RecyclerView recyclerView;
    RecyclerAdapter adapter;
    List <RecyclerAdapterCell> items = new ArrayList<>();

    @Override protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_recycler);

        updateItems();
        updateRecyclerView();
    }
    //----------------------------------------------------------------------------------------
    private void updateRecyclerView() {

        recyclerView = (RecyclerView) findViewById(R.id.recycler);
        // recyclerView.setLayoutManager(new LayoutManager(this));

        DividerItemDecoration separator = new DividerItemDecoration(recyclerView.getContext(), DividerItemDecoration.VERTICAL);
        recyclerView.addItemDecoration(separator);

        adapter = new RecyclerAdapter(items);
        recyclerView.setAdapter(adapter);

        // RecyclerView.RecycledViewPool pool = recyclerView.getRecycledViewPool();
        // pool.setMaxRecycledViews();
    }
    //----------------------------------------------------------------------------------------
    private void updateItems() {

        items.add(new RecyclerAdapterCell("афцфц", "dwadwadwa", 1 ) );

        Random rnd = new Random(1337);
        for (int i = 0; i < 15; i++) {
            switch (rnd.nextInt(3)) {
                case 0 : items.add(new ButtonCell(this)); break;
                case 1 : items.add(new  ImageCell(  "pic # "  + String.valueOf(i), R.drawable.ic_launcher_image)); break;
                case 2 : items.add(new   TextCell("Header " + String.valueOf(i), "This is text " + String.valueOf(i))); break;
            }
        }

//        for (int x = 1; x <= 23; x++) {
//            items.add(new CoffeeCell("Injir", "12 м",  " · Работает до 22:00", " · 100-180 ₽"));
//            items.add(new CoffeeCell("Crop.", "664 м", " · Работает до 22:00", " · 100-200 ₽"));
//            items.add(new CoffeeCell("1554",  "1664 м"," · Откроется в 8:00",  " · 100-150 ₽"));
//            items.add(new CoffeeCell("Даблби","664 м", " · Работает до 22:00", " · 100-180 ₽"));
//            items.add(new CoffeeCell("Орех",  "999 м", " · Откроется в 8:00",  " · 50-666 ₽" ));
//        }
    }
    //----------------------------------------------------------------------------------------
}
