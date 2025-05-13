//
//  FeedViewController.swift
//  InstagramFirebase
//
//  Created by User on 09.05.25.
//

import UIKit
import SnapKit
import FirebaseFirestore
import FirebaseAuth

class FeedViewController: UIViewController {
    
    let tableView = UITableView()
    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        call()
        getDataFireStore()
        navigationItem.hidesBackButton = true
    }
    
    func call(){
        view.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ReelPostCell.self, forCellReuseIdentifier: "ReelPostCell")
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 600
        tableView.isPagingEnabled = true
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    func getDataFireStore() {
        let firestoreDatabase = Firestore.firestore()
        let currentUserID = Auth.auth().currentUser?.uid ?? ""
        
        firestoreDatabase.collection("Posts").order(by: "date", descending: true)
            .addSnapshotListener { snapshot, error in
                if let error = error {
                    self.makeAlert(inputTitle: "Error...", inputMessage: error.localizedDescription )
                } else {
                    if let snapshot = snapshot, !snapshot.isEmpty {
                        self.posts.removeAll()
                        let group = DispatchGroup()
                        for document in snapshot.documents {
                            let data = document.data()
                            let username = data["username"] as? String ?? "user_name"
                            let caption = data["caption"] as? String ?? ""
                            let imageUrl = data["imageUrl"] as? String ?? ""
                            let likeCount = data["likeCount"] as? Int ?? 0
                            let likedUserIds = data["likedUserIds"] as? [String] ?? []
                            let isLiked = likedUserIds.contains(currentUserID)
                            
                            let post = Post(documentID: document.documentID, username: username,
                                            caption: caption,
                                            imageUrl: imageUrl,
                                            likeCount: likeCount,
                                            isLikedByCurrentUser: isLiked)
                            self.posts.append(post)
                        }
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                }
            }
    }
}

extension FeedViewController:  UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ReelPostCell", for: indexPath) as? ReelPostCell else {
            return UITableViewCell()
        }
        let post = posts[indexPath.row]
        cell.configure(with: post)
        return cell
    }
}
