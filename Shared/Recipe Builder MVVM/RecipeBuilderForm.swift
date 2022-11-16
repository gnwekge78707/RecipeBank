//
//  NewRecipeForm.swift
//  Recipe-Builder
//
//  Created by Jake Davies on 24/06/2021.
//

import SwiftUI

struct RecipeBuilderForm: View {
    @ObservedObject private var builder: RecipeBuilder
    @Environment(\.presentationMode) var presentationMode
    @State private var badSave = false
    @State private var showingImageSelector = false
    //@State private var editMode: EditMode = .inactive
    @Environment(\.editMode) var editMode
    
    init(builder: RecipeBuilder) {
        self.builder = builder
    }
    
    var body: some View {
        Form {
            recipeTitleSection
            switchButton
            loadMetaRecipe
            ingredientsSection
            instructionSection
            commentSection
            //ingredientsSection1
            
            if Camera.available || ImageSelector.available {
                imageSection
            }
            
        }
        .navigationTitle("Build Recipe")
        .navigationBarItems(leading: cancel,
                            trailing: save)
        //.toolbar(content: EditButton())
        /*.onAppear {
            editMode = .active
        }
        .onDisappear {
            editMode = .inactive
        }*/
        
        .alert(isPresented: $badSave,
               content: { badSaveAlert })
        
        .fullScreenCover(item: $imageLocation) { location in
            switch location {
            case .camera: Camera(processImage: {
                handleImage($0)
            })
            case .library: ImageSelector(processImage: {
                handleImage($0)
            })
            }
        }
        .frame(minWidth: 300, minHeight: 500)
        
        .actionSheet(isPresented: $showingImageSelector) {
            #if os(iOS)
            ActionSheet(title: Text("Add a photo"),
                        buttons: buttonSet)
            #elseif os(macOS)
            ActionSheet()
            #endif
        }
    }
    
    var switchButton : some View {
        Button {
            switch editMode?.wrappedValue {
            case .inactive:
                editMode?.wrappedValue = .active
            case .active:
                print("turn")
                editMode?.wrappedValue = .inactive
            default: break
            }
        } label: {
            if let isEditing = (editMode?.wrappedValue == .active), isEditing {
                Text("Done")
            } else {
                Text("Edit")
            }
        }
    }
    
    var loadMetaRecipe : some View {
        Section(header: Text("load meta-Recipe")) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(builder.getBook().recipes!) { recipe in
                        Button {
                            builder.setRecipe(recipe)
                        } label: {
                            Text(recipe.name ?? "")
                        }
                    }
                }
            }
        }
    }
    
    #if os(iOS)
    var buttonSet: [ActionSheet.Button] {
        var set: [ActionSheet.Button] = []
        if Camera.available {
            set.append(.default(Text("Camera")) {
                imageLocation = .camera
            })
        }
        if ImageSelector.available {
            set.append(.default(Text("Photo Library")) {
                imageLocation = .library
            })
        }
        set.append(.cancel())
        return set
    }
    #endif
    
    var recipeTitleSection: some View {
        TextField("Recipe Name", text: $builder.name)
    }
    
    var ingredientsSection: some View {
        VaryingTwinTextFieldSection(title: "Ingredients:",
                                placeholder: "New Ingredient", placeholder1: "New Amount",
                                    list: $builder.ingredients, list1: $builder.amounts)
    }

    
    var instructionSection: some View {
        VaryingTextFieldSection(title: "Instructions:",
                                placeholder: "New Instruction",
                                list: $builder.instructions)
    }
    
    //TODO! list -> comment
    var commentSection: some View {
        VaryingTextFieldSection(title: "Comments:",
                                placeholder: "New Comment",
                                list: $builder.instructions)
    }
    
    var imageSection: some View {
        Section(header: Text("Add a photo")) {
            VStack {
                if builder.image != nil {
                    OptionalImage(uiimage: UIImage(data: builder.image!))
                }
                if Camera.available || ImageSelector.available {
                    imageInputChooser
                }
            }
        }
    }
    
    var imageInputChooser: some View {
        Button() {
            showingImageSelector = true
        } label: {
            HStack {
                Spacer()
                
                Image(systemName: "photo.on.rectangle")
                
                Spacer()
            }
        }
    }
    
    struct OptionalImage: View {
        var uiimage: UIImage?
        
        var body: some View {
            if (uiimage != nil) {
                Image(uiImage: uiimage!)
                    .builderStyle()
            } else {
                Image("Logo")
                    .builderStyle()
            }
        }
    }
    
    // MARK: - Image Handling
    @State private var imageLocation: Source?
    enum Source: Identifiable {
        case camera
        case library
        var id: Source { self }
    }
    
    private func handleImage(_ image: UIImage?) {
        if let imageData = image?.imageData {
            builder.image = imageData
        }
        imageLocation = nil
    }
    
    // MARK: - User Action
    
    var cancel: some View {
        Button("Cancel") {
            self.presentationMode.wrappedValue.dismiss()
        }
    }
    
    var save: some View {
        Button("Save") {
            do {
                try self.saveEntry()
            } catch {
                badSave = true
                print(error)
            }
        }
    }
    
    // MARK: - Other
    var badSaveAlert: Alert {
        Alert(title: Text("Cannot save recipe"),
              dismissButton: .default(Text("OK")))
    }
    
    // Should delete element and fix all other elements in the list
    func deleteElement(at offsets: IndexSet, list: Binding<[String]>) {
        list.wrappedValue.remove(atOffsets: offsets)
    }
    
    func saveEntry() throws {
        // Confirm to view model
        builder.save()
        
        // Close form
        presentationMode.wrappedValue.dismiss()
    }
}

struct RecipeBuilderForm_Previews: PreviewProvider {
    static var previews: some View {
        RecipeBuilderForm(builder: RecipeBuilder(book: RecipeBook()))
            
    }
}
