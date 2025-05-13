//
//  UploadViewController.swift
//  InstagramFirebase
//
//  Created by User on 09.05.25.
//

import UIKit
import FirebaseStorage
import FirebaseFirestore
import FirebaseAuth

class UploadViewController: UIViewController , UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    
    let postImageView = UIImageView()
    let captionTextField = UITextField()
    let uploadButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
    
    func setupUI() {
        postImageView.image = UIImage(named: "placeholder")
        postImageView.backgroundColor = UIColor.systemGray5
        postImageView.contentMode = .scaleAspectFill
        postImageView.clipsToBounds = true
        postImageView.layer.cornerRadius = 16
        postImageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        postImageView.addGestureRecognizer(tapGesture)
        view.addSubview(postImageView)
        
        postImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(postImageView.snp.width).multipliedBy(1.0)
        }
        
        captionTextField.placeholder = "Write your caption..."
        captionTextField.borderStyle = .roundedRect
        captionTextField.font = UIFont.systemFont(ofSize: 16)
        view.addSubview(captionTextField)
        captionTextField.snp.makeConstraints { make in
            make.top.equalTo(postImageView.snp.bottom).offset(20)
            make.leading.trailing.equalTo(postImageView)
            make.height.equalTo(40)
        }
        
        uploadButton.setTitle("Upload", for: .normal)
        uploadButton.setTitleColor(.white, for: .normal)
        uploadButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        uploadButton.backgroundColor = .systemBlue
        uploadButton.layer.cornerRadius = 12
        uploadButton.addTarget(self, action: #selector(uploadClickedButton), for: .touchUpInside)
        view.addSubview(uploadButton)
        
        uploadButton.snp.makeConstraints { make in
            make.top.equalTo(captionTextField.snp.bottom).offset(25)
            make.centerX.equalToSuperview()
            make.width.equalTo(160)
            make.height.equalTo(45)
        }
    }
    
    @objc
    func selectImage() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            postImageView.image = selectedImage
        }
        picker.dismiss(animated: true)
    }
    @objc
    func uploadClickedButton() {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        
        let userRef = Firestore.firestore().collection("Users").document(userID)
        userRef.getDocument { document, error in
            if let document = document, document.exists {
                let username = document.get("username") as? String ?? "Unknown"
                self.uploadImageAndPost(username: username)
            } else {
                self.makeAlert(inputTitle: "Xəta", inputMessage: "İstifadəçi tapılmadı.")
            }
        }
    }
    
    func uploadImageAndPost(username: String) {
        let storage = Storage.storage()
        let storageReference = storage.reference().child("media")
        
        if let data = postImageView.image?.jpegData(compressionQuality: 0.5) {
            let uuid = UUID().uuidString
            let imageRef = storageReference.child("\(uuid).jpg")
            
            imageRef.putData(data, metadata: nil) { _, error in
                if let error = error {
                    self.makeAlert(inputTitle: "Upload error", inputMessage: error.localizedDescription)
                    return
                }
                imageRef.downloadURL { url, error in
                    if let error = error {
                        self.makeAlert(inputTitle: "URL error", inputMessage: error.localizedDescription)
                        return
                    }
                    if let imageUrl = url?.absoluteString {
                        let post: [String: Any] = [
                            "imageUrl": imageUrl,
                            "postedBy": Auth.auth().currentUser?.email ?? "",
                            "username": username,
                            "caption": self.captionTextField.text ?? "",
                            "date": FieldValue.serverTimestamp()
                        ]
                        Firestore.firestore().collection("Posts").addDocument(data: post) { error in
                            if let error = error {
                                self.makeAlert(inputTitle: "DB error", inputMessage: error.localizedDescription)
                            } else {
                                self.makeAlert(inputTitle: "Uğurlu", inputMessage: "Post əlavə olundu!")
                                self.postImageView.image = UIImage(named: "placeholder")
                                self.captionTextField.text = ""
                                self.tabBarController?.selectedIndex = 0
                            }
                        }
                    }
                }
            }
        }
    }
}
