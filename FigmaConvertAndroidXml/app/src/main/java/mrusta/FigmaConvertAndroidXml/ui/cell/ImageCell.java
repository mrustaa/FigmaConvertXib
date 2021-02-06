package mrusta.FigmaConvertAndroidXml.ui.cell;

import mrusta.FigmaConvertAndroidXml.R;
import mrusta.FigmaConvertAndroidXml.framework.recyclerAdapter.Interface.RecyclerAdapterCell;

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


public class ImageCell extends RecyclerAdapterCell {
    //-----------------------------------------------------------------------------------
    @Override public int type() { return 4; }

    @Override public void fill(RecyclerView.ViewHolder viewHolder) {
        ImageHolder holder = (ImageHolder) viewHolder;
                    holder.textView.setText(text);
                    holder.imageView.setImageResource(image);
    }

    public static class ImageHolder extends RecyclerView.ViewHolder {

        public ImageView imageView;
        public TextView textView;

        public ImageHolder(View itemView) {
            super(itemView);
            imageView = (ImageView) itemView.findViewById(R.id.image);
            textView  = (TextView)  itemView.findViewById(R.id.text_image);
        }
    }
    //------------------------------------------------------------------------------------
    @Override public RecyclerView.ViewHolder createHolderItem(ViewGroup parent) {
        return ImageCell.createHolder(parent);
    }

    public static RecyclerView.ViewHolder createHolder(ViewGroup parent) {
        View xml = LayoutInflater.from(parent.getContext()).inflate(R.layout.cell_image, parent,false);
        return new ImageCell.ImageHolder(xml);
    }
    //------------------------------------------------------------------------------------
    private String text;
    private int image;

    public ImageCell(String text,
                     int image) {
        this.text = text;
        this.image = image;
    }
    //------------------------------------------------------------------------------------
}
