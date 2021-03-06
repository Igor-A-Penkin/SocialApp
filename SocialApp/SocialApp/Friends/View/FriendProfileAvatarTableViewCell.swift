//
//  FriendProfileAvatarTableViewCell.swift
//  SocialApp
//
//  Created by Игорь Пенкин on 24.10.2020.
//

import UIKit

class FriendProfileAvatarTableViewCell: UITableViewCell {

    @IBOutlet weak var photoImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func congigureCell(avatar: UIImage?) {
        //self.photoImage.contentMode = .scaleAspectFill
        self.photoImage.image = avatar ?? UIImage(named: "camera")
//        self.frame.size.height = self.bounds.width
//        self.photoImage.frame.size.height = self.bounds.width
//        self.photoImage.frame.size.width = self.bounds.width
    }
    
}
