//
//  XibFigmaKeyFileViewControllerAndroid.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 29.08.2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

import Foundation

extension FigmaNode {
    
    // MARK: - Gen Swift ViewController
    
    func xmlGenFileRecyclerActivity() -> String {
        
        let name_    = genNameFileJava(type: .tableVC)
        let nameXML_ = genNameFileXML (type: .tableVC)
        
        return """
        package mrusta.FigmaConvertAndroidXml.ui.screen;
        
        import mrusta.FigmaConvertAndroidXml.framework.recyclerAdapter.Interface.RecyclerAdapterCell;
        import mrusta.FigmaConvertAndroidXml.framework.recyclerAdapter.RecyclerAdapter;
        import mrusta.FigmaConvertAndroidXml.framework.recyclerAdapter.RecyclerAdapterClick;

        import androidx.appcompat.app.AppCompatActivity;
        import android.os.Bundle;

        import androidx.annotation.NonNull;
        import mrusta.FigmaConvertAndroidXml.R;
        
        import androidx.recyclerview.widget.DividerItemDecoration;
        import androidx.recyclerview.widget.RecyclerView;
        
        import java.util.ArrayList;
        import java.util.List;
        
        
        public class \(name_) extends AppCompatActivity {
            
            RecyclerView recyclerView;
            RecyclerAdapter adapter;
            List <RecyclerAdapterCell> items = new ArrayList<>();
            
            //----------------------------------------------------------------------------------------
            @Override protected void onCreate(Bundle savedInstanceState) {
                super.onCreate(savedInstanceState);
                setContentView(R.layout.\(nameXML_));
                
                updateItems();
                updateRecyclerView();
            }
            
            //----------------------------------------------------------------------------------------
            private void updateRecyclerView() {
                
                recyclerView = (RecyclerView) findViewById(R.id.recycler);
                
                // DividerItemDecoration separator = new DividerItemDecoration(recyclerView.getContext(), DividerItemDecoration.VERTICAL);
                // recyclerView.addItemDecoration(separator);
                
                adapter = new RecyclerAdapter(items);
                recyclerView.setAdapter(adapter);
            }
            
            //----------------------------------------------------------------------------------------
            private void updateItems() {
            
            }
        }
        """
    }
    
}
