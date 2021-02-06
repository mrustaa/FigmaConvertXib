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


public class ButtonCell extends RecyclerAdapterCell {
    //------------------------------------------------------------------------------------
    @Override public int type() { return 8; }

    @Override public void fill(RecyclerView.ViewHolder viewHolder) {
        ButtonHolder cell = (ButtonHolder) viewHolder;
                     cell.button.setOnClickListener(getOnClickListener());

    }

    public static class ButtonHolder extends RecyclerView.ViewHolder {

        public Button button;


        public ButtonHolder(View itemView) {
            super(itemView);
            button = (Button) itemView.findViewById(R.id.button);

        }
    }
    //------------------------------------------------------------------------------------
    @Override public RecyclerView.ViewHolder createHolderItem(ViewGroup parent) {
        return ButtonCell.createHolder(parent);
    }

    public static RecyclerView.ViewHolder createHolder(ViewGroup parent) {
        View xml = LayoutInflater.from(parent.getContext()).inflate(R.layout.cell_button, parent,false);
        return new ButtonCell.ButtonHolder(xml);
    }
    //------------------------------------------------------------------------------------
    private Context context;
    public ButtonCell(Context context) {
        this.context = context;
    }

    public View.OnClickListener getOnClickListener() {
        return new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Toast.makeText(context, "Click!", Toast.LENGTH_SHORT).show();
            }
        };
    }
    //------------------------------------------------------------------------------------
}
