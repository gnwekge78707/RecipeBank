import SwiftUI

struct DDragListSwipeAction: View {
    @State var datas: [(String,[String])] = [("诗歌", ["黄瓜不只", "是黄瓜", "今天天气", "还是不错的"]),
                                             ("古诗词", ["床前明月光", "疑是地上霜", "举头望明月", "低头思故乡"])]
    var body: some View {
        List {
            ForEach(datas.indices, id: \.self) { index in
                if #available(iOS 15.0, *) {
                    Section(datas[index].0) {
                        var subs = datas[index].1
                        ForEach(subs, id: \.self) { sub in
                            Text(sub)
                                .onDrag {
                                    let provider = NSItemProvider.init(object: NSString(string: sub))
                                    return provider
                                }
                                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                    Button {
                                        let offset = subs.firstIndex(of: sub)
                                        subs.remove(at: offset!)
                                        datas[index].1 = subs
                                    } label: {
                                        Image(systemName: "trash")
                                    }
                                    .tint(.red)
                                    
                                    Button {
                                        print("edit")
                                    } label: {
                                        Image(systemName: "square.and.pencil")
                                    }
                                    .tint(.orange)
                                }
                            
                        }
                        .onMove { fromSet, to in
                            subs.move(fromOffsets: fromSet, toOffset: to)
                            datas[index].1 = subs
                        }
                        //.onInsert(of: ["public.text"], perform: dropList)
                    }
                } else {
                    // Fallback on earlier versions
                }
            }
        }
    }
    /*
    func dropList(at index: Int, _ items: [NSItemProvider]) {
            for item in items {
                _ = item.loadObject(ofClass: String.self) { droppedString, _ in
                    if let ss = droppedString {
                        DispatchQueue.main.async {
                            self.users1.insert(ss, at: index)
                            self.users2.removeAll { $0 == ss }
                        }
                    }
                }
            }
        }*/
}

struct DDragListSwipeAction_Previews: PreviewProvider {
    static var previews: some View {
        DDragListSwipeAction()
    }
}
