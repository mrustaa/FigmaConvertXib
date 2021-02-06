package mrusta.FigmaConvertAndroidXml.framework.recyclerAdapter.Interface;

import mrusta.FigmaConvertAndroidXml.framework.recyclerAdapter.Interface.RecyclerAdapterCell;

import androidx.annotation.NonNull;
import mrusta.FigmaConvertAndroidXml.R;
import androidx.recyclerview.widget.RecyclerView;
import android.view.LayoutInflater;

import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;
import android.widget.ImageView;
import android.content.Context;
import android.widget.Button;
import android.widget.Toast;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;



public class RecyclerAdapterCell {
    //------------------------------------------------------------------------------------
    // public static int typeClass() { return 0; }

    /** тип id */
    public int type() { return 0; }

    /** заполнить данные */
    public void fill(RecyclerView.ViewHolder viewHolder) { }

    public void selected(View v, int position) { }

    /** ячейка */
    public static class RecyclerAdapterHolder extends RecyclerView.ViewHolder {
        final ImageView image;
        final TextView title, subtitle;

        RecyclerAdapterHolder(View itemView) {
            super(itemView);
            image    = (ImageView)itemView.findViewById(R.id.image    );
            title    = (TextView) itemView.findViewById(R.id.title    );
            subtitle = (TextView) itemView.findViewById(R.id.subtitle );
        }
    }
    //------------------------------------------------------------------------------------
    /** создать ячейку + xml */
    public RecyclerView.ViewHolder createHolderItem(ViewGroup parent) {
        return RecyclerAdapterCell.createHolder(parent);
    }

    public static RecyclerView.ViewHolder createHolder(ViewGroup parent) {
        View xml = LayoutInflater.from(parent.getContext()).inflate(R.layout.cell_recycler, parent, false);
        return new RecyclerAdapterCell.RecyclerAdapterHolder(xml);
    }
    //------------------------------------------------------------------------------------
    private String title;
    private String subtitle;
    private int image;

    public RecyclerAdapterCell() {
        this.title = ""; this.subtitle = ""; this.image = 0;
    }

    public RecyclerAdapterCell(String name, String company, int image) {
        this.title = name; this.subtitle = company; this.image = image;
    }
    //------------------------------------------------------------------------------------
}
