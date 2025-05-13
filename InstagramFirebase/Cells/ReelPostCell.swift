//
//  ReelPostCell.swift
//  InstagramFirebase
//
//  Created by User on 11.05.25.
//

import Foundation
import UIKit
import SnapKit
import SDWebImage
import Firebase
class ReelPostCell: UITableViewCell {
    
    let profileImageView = UIImageView()
    let usernameLabel = UILabel()
    let followButton = UIButton(type: .system)
    let postImageView = UIImageView()
    let likeButton = UIButton(type: .system)
    let likeCountLabel = UILabel()
    let captionLabel = UILabel()
    private var currentLikeCount = 0
    var isLikedByCurrentUser = false
    var postId: String?
    var post: Post?
    private var currentUserID: String? {
        return Auth.auth().currentUser?.uid
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        selectionStyle = .none
        
        contentView.addSubview(profileImageView)
        profileImageView.image = UIImage(systemName: "person.crop.circle")
        profileImageView.tintColor = .black
        profileImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(20)
            make.width.height.equalTo(40)
        }
        
        contentView.addSubview(usernameLabel)
        usernameLabel.font = .boldSystemFont(ofSize: 16)
        usernameLabel.text = "user_name"
        usernameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(profileImageView)
            make.leading.equalTo(profileImageView.snp.trailing).offset(10)
        }
        
        contentView.addSubview(followButton)
        followButton.setTitle("Follow", for: .normal)
        followButton.setTitleColor(.black, for: .normal)
        followButton.snp.makeConstraints { make in
            make.centerY.equalTo(profileImageView)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        contentView.addSubview(postImageView)
        postImageView.contentMode = .scaleAspectFill
        postImageView.clipsToBounds = true
        postImageView.backgroundColor = .lightGray
        postImageView.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(postImageView.snp.width)
        }
        
        contentView.addSubview(likeButton)
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        likeButton.snp.makeConstraints { make in
            make.top.equalTo(postImageView.snp.bottom).offset(10)
            make.leading.equalTo(postImageView.snp.leading)
        }
        
        contentView.addSubview(likeCountLabel)
        likeCountLabel.text = "0 likes"
        likeCountLabel.snp.makeConstraints { make in
            make.centerY.equalTo(likeButton)
            make.leading.equalTo(likeButton.snp.trailing).offset(10)
        }
        
        contentView.addSubview(captionLabel)
        captionLabel.text = "Sample caption..."
        captionLabel.numberOfLines = 0
        captionLabel.snp.makeConstraints { make in
            make.top.equalTo(likeButton.snp.bottom).offset(10)
            make.leading.trailing.equalTo(postImageView)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
    struct Item {
        var username: String
        var postImageURL: String
        var like: Bool
        var likeCount: Int
        var caption: String
    }
    
    func configure(with item: Post) {
        self.post = item
        if let url = URL(string: item.imageUrl) {
            postImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"))
        }
        usernameLabel.text = item.username
        captionLabel.text = item.caption
        likeCountLabel.text = "\(item.likeCount) likes"
        isLikedByCurrentUser = item.isLikedByCurrentUser
        let heartImage = UIImage(systemName: item.isLikedByCurrentUser ? "heart.fill" : "heart")
        likeButton.setImage(heartImage, for: .normal)
        currentLikeCount = item.likeCount
        likeButton.removeTarget(nil, action: nil, for: .allEvents)
        likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
    }
    @objc
    func likeButtonTapped() {
        let firestoreDatabase = Firestore.firestore()
        guard let postDocumentID = post?.documentID else { return }
        
        if isLikedByCurrentUser {
            currentLikeCount -= 1
            likeCountLabel.text = "\(currentLikeCount) likes"
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
                firestoreDatabase.collection("Posts").document(postDocumentID).updateData([
                "likeCount": currentLikeCount,
                "likedUserIds": FieldValue.arrayRemove([currentUserID ?? ""])
            ]) { error in
                if let error = error {
                    print("Error updating like count: \(error.localizedDescription)")
                } else {
                    self.isLikedByCurrentUser = false
                }
            }
        } else {
            currentLikeCount += 1
            likeCountLabel.text = "\(currentLikeCount) likes"
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            firestoreDatabase.collection("Posts").document(postDocumentID).updateData([
                "likeCount": currentLikeCount,
                "likedUserIds": FieldValue.arrayUnion([currentUserID ?? ""])
            ]) { error in
                if let error = error {
                    print("Error updating like count: \(error.localizedDescription)")
                } else {
                    self.isLikedByCurrentUser = true
                }
            }
        }
    }
}
