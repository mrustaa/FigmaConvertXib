package mrusta.FigmaConvertAndroidXml.framework.recyclerAdapter;

import mrusta.FigmaConvertAndroidXml.framework.recyclerAdapter.RecyclerAdapter;
import mrusta.FigmaConvertAndroidXml.framework.recyclerAdapter.Interface.RecyclerAdapterCell;
import mrusta.FigmaConvertAndroidXml.framework.recyclerAdapter.RecyclerAdapterFactory;

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



public class RecyclerAdapterFactory {

    public static RecyclerView.ViewHolder createHolder(ViewGroup parent, int type, List <RecyclerAdapterCell> items) {

        RecyclerAdapterCell finded = new RecyclerAdapterCell();

        for (RecyclerAdapterCell item : items) {
            int iType = item.type();
            if (type == iType) {
                finded = item;
            }
        }
        return finded.createHolderItem(parent);
    }
}
