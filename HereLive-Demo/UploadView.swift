//
//  UploadView.swift
//  HereLive-Demo
//
//  Created by Yvonne J on 4/21/24.
//

import SwiftUI

struct UploadView: View {
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var postImage: Image?
    @State private var postLocation = ""

    var body: some View {
        NavigationView {
            VStack {
                Spacer()

                if let postImage = postImage {
                    postImage
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                } else {
                    Button(action: {
                        self.showingImagePicker = true
                    }) {
                        Image(systemName: "camera")
                            .font(.system(size: 60))
                            .padding()
                            .foregroundColor(.orange)
                    }
                }

                TextField("Location", text: $postLocation)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .foregroundColor(Color.orange)

                Button("Upload Post") {
                    // Here you would add the image and location to your feed model
                    // Make sure you handle this in your app architecture
                }
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .clipShape(Capsule())

                Spacer()
            }
            .navigationBarTitle("New Post", displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                // Code to open settings or other features
            }) {
                Image(systemName: "line.horizontal.3")
                    .foregroundColor(.green)
            })
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                ImagePicker(selectedImage: $inputImage)
            }
        }
    }

    func loadImage() {
        guard let inputImage = inputImage else { return }
        postImage = Image(uiImage: inputImage)
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    @Environment(\.presentationMode) var presentationMode

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.selectedImage = image
            }

            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}

struct UploadView_Previews: PreviewProvider {
    static var previews: some View {
        UploadView()
    }
}
