//
//  FriendsTableViewController.swift
//  SocialApp
//
//  Created by Игорь Пенкин on 05.10.2020.
//

import UIKit

class FriendsTableViewController: UITableViewController, UISearchResultsUpdating {
    
    @IBOutlet weak var friendsTableView: UITableView!
    
    let friendsArray: [User] = [
        User(name: "Johnny", lastName: "Appleseed", image: UIImage(named: "guy")!, age: 18),
        User(name: "Bobby", lastName: "Axelroude", image: UIImage(named: "guy")!, age: 18),
        User(name: "Michael", lastName: "Composer", image: UIImage(named: "guy")!, age: 18),
        User(name: "Bob", lastName: "Dommergoo", image: UIImage(named: "guy")!, age: 18),
        User(name: "Micky", lastName: "Fiedgerald", image: UIImage(named: "guy")!, age: 18),
        User(name: "Tom", lastName: "Hawkins", image: UIImage(named: "guy")!, age: 18),
        User(name: "Alex", lastName: "Burntman", image: UIImage(named: "guy")!, age: 18),
        User(name: "Mike", lastName: "Rouhgeman", image: UIImage(named: "guy")!, age: 18),
        User(name: "Rashid", lastName: "Daddario", image: UIImage(named: "guy")!, age: 18),
        User(name: "Jude", lastName: "Chappman", image: UIImage(named: "guy")!, age: 18),
        User(name: "Alexander", lastName: "Cross", image: UIImage(named: "guy")!, age: 18)
    ]
    
    var friendIndex: [String] = []
    
    func createIndex() {
        // Logic of indexation - getting unique first letter of .lastName into friendIndex[]
        var temporaryIndex: [String] = []
        for item in friendsArray {
            temporaryIndex.append(String(item.lastName.first!))
        }
        friendIndex = Array(Set(temporaryIndex)).sorted()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        friendsTableView.delegate = self
        friendsTableView.dataSource = self
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        let searchBar = UISearchController(searchResultsController: nil)
        searchBar.searchResultsUpdater = self
        self.navigationItem.searchController = searchBar
        
        createIndex()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return friendIndex.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return String(friendIndex[section])
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 28))
        sectionHeaderView.backgroundColor = UIColor.systemGray5
        
        let label = UILabel(frame: CGRect(x: 10, y: 0, width: sectionHeaderView.frame.width, height: 28))
        label.text = String(friendIndex[section])
        label.tintColor = .label
        
        sectionHeaderView.addSubview(label)
        
        return sectionHeaderView
    }
    
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return friendIndex
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let buffer = friendsArray.filter{ (friend) -> Bool in
            friendIndex[section] == String(friend.lastName.first!)
        }
        
        return buffer.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsTableViewCell", for: indexPath) as! FriendsTableViewCell
        
        let buffer = friendsArray.filter{ (friend) -> Bool in
            friendIndex[indexPath.section] == String(friend.lastName.first!)
        }
        
        cell.friendName.text = "\(buffer[indexPath.row].lastName) \(buffer[indexPath.row].name)"
        cell.friendImage.image = buffer[indexPath.row].image
        cell.friendLastSeen.text = "Last seen recently"
        
        
        return cell
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        print(searchController.searchBar.text!)
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "segueToPhotos":
            let photosCVC = segue.destination as! PhotosCollectionViewController
            photosCVC.title = "Photoflow"
            photosCVC.imageArray = [UIImage(named: "unknown"), UIImage(named: "musicGroup"), UIImage(named: "guy")]
        case "segueToPeople":
            print("Segue to People has been choosen.")
            return
        case "segueToFriendProfile":
            if let indexPath = friendsTableView.indexPathForSelectedRow {
//                 if isFiltering {
//                    friend = searchedFriend[indexPath.row]
//                 } else {
//                    friend = friendsArray[indexPath.row]
//                 }
                let buffer = friendsArray.filter{ (friend) -> Bool in
                    friendIndex[indexPath.section] == String(friend.lastName.first!)
                }
                let friend: User
                friend = buffer[indexPath.row]
                let friendProfileVC = segue.destination as! FriendProfileViewController
                friendProfileVC.title = "\(friend.lastName) \(friend.name)"
            }
        default:
            print("ERROR - NAVIGATION: Unknown segue from FriendsTableViewController.")
            return
        }
        
    }
    
}