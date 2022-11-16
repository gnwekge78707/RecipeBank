//
//  VaryingTwinTextFieldSection.swift
//  Recipe-Builder
//
//  Created by jiarui on 2022/11/14.
//

import SwiftUI

struct VaryingTwinTextFieldSection: View {
    @State private var failed: Bool = false
    @State private var editMode: EditMode = .inactive
    var title: String = ""
    var placeholder: String = ""
    var placeholder1: String = ""
    var list: Binding<[String]>
    var list1: Binding<[String]>
    
    init(title: String, placeholder: String, placeholder1: String, list: Binding<[String]>, list1: Binding<[String]>) {
        self.list = list
        self.list1 = list1
        if self.list.wrappedValue.isEmpty {
            self.list.wrappedValue.append("")
        }
        if self.list1.wrappedValue.isEmpty {
            self.list1.wrappedValue.append("")
        }
        self.title = title
        self.placeholder = placeholder
        self.placeholder1 = placeholder1
    }
    
    var body: some View {
        /*
        Section(header: header) {
            List {
                ForEach(0..<list.wrappedValue.count, id: \.self) { number in
                    if number == list.wrappedValue.count - 1 { // if last item
                        HStack(spacing: 5) {
                            TextField(placeholder, text: list[number])
                            TextField(placeholder1, text: list1[number])
                            plus
                        }
                    } else {
                        HStack(spacing: 5) {
                            TextField(placeholder, text: list[number])
                            TextField(placeholder1, text: list1[number])
                            Spacer()
                        }
                    }
                }
                .onDelete(perform: { indexSet in
                    deleteElement(at: indexSet)
                })
                .onMove(perform: move(from:to:))
            }.toolbar {
                EditButton()
            }
        }
        .alert(isPresented: $failed,
               content: { badEntryAlert })
         */
        Section(header: header) {
            List {
                ForEach(0..<list.wrappedValue.count, id: \.self) { number in
                    /*if number == list.wrappedValue.count - 1 { // if last item
                        HStack(spacing: 5) {
                            TextField(placeholder, text: list[number])
                            TextField(placeholder1, text: list1[number])
                        }
                    } else {
                        HStack(spacing: 5) {
                            TextField(placeholder, text: list[number])
                            TextField(placeholder1, text: list1[number])
                        }
                    }*/
                    HStack(spacing: 5) {
                        TextField(placeholder, text: list[number])
                        TextField(placeholder1, text: list1[number])
                    }
                    /*
                    .onDrag {
                        let provider = NSItemProvider(item: .some(URL(string: "number") as! NSSecureCoding), typeIdentifier: String() )
                        return provider
                    }*/
                }
                .onMove(perform: move(from:to:))
                .onDelete(perform: { indexSet in
                    deleteElement(at: indexSet)
                })
            }
            HStack {
                plus
                Spacer()
                plusGroup
            }
        }
        //.environment(\.editMode, .constant(.active))

        .alert(isPresented: $failed,
                content: { badEntryAlert })
        
        
    }
    
    var header: some View {
        Text(title)
    }
    
    var plus: some View {
        Button("+") {
            if !list.wrappedValue.contains("") {
                list.wrappedValue.append("")
                list1.wrappedValue.append("")
            } else {
                failed = true
            }
        }
    }
    
    var plusGroup: some View {
        Button("+") {
            if !list.wrappedValue.contains("") {
                list.wrappedValue.append("")
                list1.wrappedValue.append("")
            } else {
                failed = true
            }
        }
    }

    
    var badEntryAlert: Alert {
        Alert(title: Text("Please fill in blank fields first"),
              dismissButton: .default(Text("OK")))
    }
    
    func deleteElement(at offsets: IndexSet) {
        list.wrappedValue.remove(at: offsets.first!)
        list1.wrappedValue.remove(at: offsets.first!)
    }
    
    func move(from source: IndexSet, to destination: Int) {
        list.wrappedValue.move(fromOffsets: source, toOffset: destination)
        list1.wrappedValue.move(fromOffsets: source, toOffset: destination)
    }
    
}
    
    
    
/*
    
    View {
    @State private var failed: Bool = false
    var list : [(String, String)] = [("apple","1lb"), ("suger","30g")]
    var title: String = ""
    var placeholder: String = ""
    
    init() {
        self.title = "MyList"
    }

    
    var body: some View {
        Section(header: header) {
            List {
                ForEach(0..<list.count, id: \.self) { number in
                    if number == list.count - 1 { // if last item
                        HStack(spacing: 5) {
                            TextField(placeholder, text: list[number].0)
                            TextField(placeholder, text: list[number].1)
                            plus
                        }
                    } else {
                        TextField(placeholder, text: list[number].0)
                        TextField(placeholder, text: list[number].1)
                    }
                }

            }
        }

    }
    
    var header: some View {
        Text(title)
    }
    
    var plus: some View {
        Button("+") {
            if !list.contains(where: ("","")) {
                list.append(("",""))
            } else {
                failed = true
            }
        }
    }
    
}

struct VaryingTwinTextFieldSection_Previews: PreviewProvider {
    static var previews: some View {
        VaryingTwinTextFieldSection()
    }
}
*/
