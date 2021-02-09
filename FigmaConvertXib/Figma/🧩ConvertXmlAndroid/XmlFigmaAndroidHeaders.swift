//
//  XibAndroidFigmaViews.swift
//  FigmaConvertXib
//
//  Created by Рустам Мотыгуллин on 18.08.2020.
//  Copyright © 2020 mrusta. All rights reserved.
//

import Foundation
import UIKit


extension FigmaNode {
    
    
    // MARK: - CardView
    
    func cardViewXmlAndroid(radius: CGFloat, index: Int) -> (header: String, end_settings: String, end: String) {
        
        let nameId = "card\(index)" // xibId
        
        let header = """
        
        
        <androidx.cardview.widget.CardView
            android:id="@+id/\(nameId)"
            app:layout_constraintStart_toStartOf="parent"
            app:layout_constraintTop_toTopOf="parent"
            
            app:cardElevation="0dp"
            app:cardCornerRadius="\(radius)dp"
        """
        // --------------------------------------------------
        let end_settings = """
            >
        """
        
        // -------------------------------------------------
        let end = """

        </androidx.cardview.widget.CardView>
        """
        
        return (header, end_settings, end)
    }
    
    
    
    
    // MARK: - View
    
    func viewXmlAndroid(main: Bool = false, index: Int) -> (header: String, end_settings: String, end: String) {
        
        let nameId = "view\(index)" // xibId
        
        var header = """
        
        
        <androidx.constraintlayout.widget.ConstraintLayout
            android:id="@+id/\(nameId)"
            app:layout_constraintStart_toStartOf="parent"
            app:layout_constraintTop_toTopOf="parent"
        """
        if main {
            header = """
            <?xml version="1.0" encoding="utf-8"?>
            <androidx.constraintlayout.widget.ConstraintLayout
                xmlns:android="http://schemas.android.com/apk/res/android"
                xmlns:app="http://schemas.android.com/apk/res-auto"
                xmlns:tools="http://schemas.android.com/tools"
            """

        }
        // --------------------------------------------------
        var end_settings = """
            >
        """
        
        if main {
            end_settings = """
            
                tools:context=".ui.MainActivity"
                android:id="@+id/main"
                >
            """
        }
        // -------------------------------------------------
        let end = """

        </androidx.constraintlayout.widget.ConstraintLayout>
        """
        
        return (header, end_settings, end)
    }
    
    
    
    // MARK: - ImageView

    func labelXmlAndroid(index: Int) -> (header: String, end_settings: String, end: String) {
        
        let nameId = "text\(index)" // xibId
        
        let header = """


        <TextView
            android:id="@+id/\(nameId)"
            tools:ignore="HardcodedText"
            app:layout_constraintStart_toStartOf="parent"
            app:layout_constraintTop_toTopOf="parent"
            
            android:fontFamily="sans-serif"
        """
        
        // -------------------------------------------------
        let end = """
        
        />
        """
        
        return (header, "", end)
        
    }
    
    
    
    // MARK: - ImageView

    func imageXmlAndroid(index: Int) -> (header: String, end_settings: String, end: String) {
        
        let nameId = "image\(index)" // xibId
        
        let header = """
        
        <ImageView
            android:id="@+id/\(nameId)"
            tools:ignore="ContentDescription"
            app:layout_constraintStart_toStartOf="parent"
            app:layout_constraintTop_toTopOf="parent"
        """
        // -------------------------------------------------
        let end = """
        
        />
        """
        
        return (header, "", end)
    }

    
}
    
