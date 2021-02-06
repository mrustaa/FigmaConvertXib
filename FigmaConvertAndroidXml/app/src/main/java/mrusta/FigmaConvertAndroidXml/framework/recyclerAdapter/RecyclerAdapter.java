package mrusta.FigmaConvertAndroidXml.framework.recyclerAdapter;

import mrusta.FigmaConvertAndroidXml.framework.recyclerAdapter.Interface.RecyclerAdapterCell;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import android.util.Log;
import android.view.ViewGroup;

import java.util.List;

public class RecyclerAdapter extends RecyclerView.Adapter {

    public List <RecyclerAdapterCell> items;

    public RecyclerAdapter(List <RecyclerAdapterCell> items) {
        this.items = items;
    }

    public int lastItemPosition = -1;
    //------------------------------------------------------------------------------------
    /** колличество */
    @Override public int getItemCount() {
        return this.items.size();
    }

    /** тип */
    @Override public int getItemViewType(int position) {

        if (position != lastItemPosition) {
            lastItemPosition = position;

            //Log.d("️", String.valueOf(position));
        }

        return this.items.get(position).type();
    }

    /** создать */
    @Override public RecyclerView.ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        return RecyclerAdapterFactory.createHolder(parent, viewType, items);
    }

    /** заполнить данные */
    @Override public void onBindViewHolder(@NonNull RecyclerView.ViewHolder holder, int position) {
        items.get(position).fill(holder);
    }
    //------------------------------------------------------------------------------------
}
