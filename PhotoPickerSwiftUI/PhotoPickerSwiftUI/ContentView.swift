//
//  ContentView.swift
//  PhotoPickerSwiftUI
//
//  Created by Berkay Kuzu on 24.09.2022.
//

import SwiftUI
import PhotosUI

struct ContentView: View {
    
    @State var selectedItem : [PhotosPickerItem] = []
    @State var data : Data?

    var body: some View {
        VStack {
            
            if let data = data {
                if let selectedImage = UIImage(data: data) {
                    Spacer()
                    Image(uiImage: selectedImage)
                        .resizable()
                        .frame(width: 300, height: 250, alignment: .center)
                }
            }
            
            Spacer()
            
            PhotosPicker(selection: $selectedItem, maxSelectionCount: 1, matching: .images) {
                Text("Select Image")
            }.onChange(of: selectedItem) { newValue in
                guard let item = selectedItem.first else {
                    return
                } //Yaptığımız işlemi data'ya çevirecek!
                item.loadTransferable(type: Data.self) { result in
                    switch result {
                    case.success(let data):
                        if let data = data {
                            self.data = data
                        }
                    case.failure(let error):
                        print(error)
                    }
                }
            } //Photos Picker değişince ne olacak?
            
            
        }
       
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
