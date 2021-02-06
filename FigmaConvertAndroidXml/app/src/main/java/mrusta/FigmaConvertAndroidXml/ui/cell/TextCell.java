package mrusta.FigmaConvertAndroidXml.ui.cell;

import androidx.annotation.NonNull;
import mrusta.FigmaConvertAndroidXml.R;
import androidx.recyclerview.widget.RecyclerView;
import mrusta.FigmaConvertAndroidXml.framework.recyclerAdapter.Interface.RecyclerAdapterCell;
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


public class TextCell extends RecyclerAdapterCell {
    //------------------------------------------------------------------------------------
    @Override public int type() { return 2; }

    @Override public void fill(RecyclerView.ViewHolder viewHolder) {
        TextHolder cell = (TextHolder) viewHolder;
                   cell.headerTextView.setText(header);
                   cell.textView.setText(text);
    }

    public static class TextHolder extends RecyclerView.ViewHolder {
        public TextView headerTextView, textView;

        public TextHolder(View itemView) {
            super(itemView);
            headerTextView  = (TextView) itemView.findViewById(R.id.header);
            textView        = (TextView) itemView.findViewById(R.id.text);
        }
    }
    //------------------------------------------------------------------------------------
    @Override public RecyclerView.ViewHolder createHolderItem(ViewGroup parent) {
        return TextCell.createHolder(parent);
    }

    public static RecyclerView.ViewHolder createHolder(ViewGroup parent) {
        View xml = LayoutInflater.from(parent.getContext()).inflate(R.layout.cell_text, parent,false);
        return new TextCell.TextHolder(xml);
    }
    //------------------------------------------------------------------------------------
    private String header, text;

    public TextCell(String header, String text) {
        this.header = header;
        this.text = text;
    }
    //------------------------------------------------------------------------------------
}
