//
//  XibFigmaKeyFileCellAndroid.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 29.08.2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

import Foundation

extension FigmaNode {
    
    // MARK: - Gen Java R.View.Holder
    
    func xmlGenFileCell() -> String {
        
        let name_ = name.xibFilterName(type: .cell)
        
        let nameXML = genNameFileXML(type: .cell)
        
        let typeId = Int.random(in: 0..<99999)
        
        
        let holderSet_      = propertyChildrenAndroid(type: .holderSet).connections
        let holderSet       = genArr(holderSet_, 8, false)
        
        let holderProperty_ = propertyChildrenAndroid(type: .holderProperty).connections
        let holderProperty  = genArr(holderProperty_, 4, true)
        
        let holderFindId_   = propertyChildrenAndroid(type: .holderFindId).connections
        let holderFindId    = genArr(holderFindId_, 4, true)
        
        let cellProperty_   = propertyChildrenAndroid(type: .cellProperty).connections
        let cellProperty    = genArr(cellProperty_, 4, true)
        
        let cellInit_       = propertyChildrenAndroid(type: .cellInit).connections
        let cellInit        = genArr(cellInit_, 4, true)
        
        let cellSet_        = propertyChildrenAndroid(type: .cellSet).connections
        let cellSet         = genArr(cellSet_, 4, true)
        
        
        return """
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
        
        
        public class \(name_)Cell extends RecyclerAdapterCell {
            //------------------------------------------------------------------------------------
            @Override public int type() { return \(typeId); }

            @Override public void fill(RecyclerView.ViewHolder viewHolder) {
                \(name_)Holder holder = (\(name_)Holder) viewHolder;
                \(holderSet)
            }

            public static class \(name_)Holder extends RecyclerView.ViewHolder {
        
                \(holderProperty)

                public \(name_)Holder(View itemView) {
                    super(itemView);
        
                    \(holderFindId)
                }
            }
            //------------------------------------------------------------------------------------
            @Override public RecyclerView.ViewHolder createHolderItem(ViewGroup parent) {
                return \(name_)Cell.createHolder(parent);
            }

            public static RecyclerView.ViewHolder createHolder(ViewGroup parent) {
                View xml = LayoutInflater.from(parent.getContext()).inflate(R.layout.\(nameXML), parent,false);
                return new \(name_)Cell.\(name_)Holder(xml);
            }
            //------------------------------------------------------------------------------------
            \(cellProperty)

            public \(name_)Cell(\(cellInit)) {
        
                \(cellSet)
            }
            //------------------------------------------------------------------------------------
        }
        """
    }
}
