//
//  HomeController.swift
//  HowlFireBaseLogin
//
//  Created by 유명식 on 2017. 6. 17..
//  Copyright © 2017년 swift. All rights reserved.
//

import UIKit
import Firebase

class HomeController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {

    @IBOutlet weak var colleectView: UICollectionView!
    var array : [UserDTO] = []
    var uidKey : [String] = []
    
    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        
        return array.count
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RowCell", for: indexPath) as! CustomCell
        
        cell.subject.text = array[indexPath.row].subject
        cell.explaination.text = array[indexPath.row].explaination
        
        
        let data = try? Data(contentsOf: URL(string: array[indexPath.row].imageUrl!)!)
        cell.imageView.image = UIImage(data: data!)
        
        
        return cell
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        FIRDatabase.database().reference().child("users").observe(FIRDataEventType.value, with: { (FIRDataSnapshot) in
            
            self.array.removeAll()
            
            for child in FIRDataSnapshot.children{
                let fchild = child as! FIRDataSnapshot
                let userDTO = UserDTO()
                userDTO.setValuesForKeys(fchild.value as! [String:Any])
                self.array.append(userDTO)
                
                
                
            }
            self.colleectView.reloadData()
            
            
        })
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


class CustomCell : UICollectionViewCell{
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var subject: UILabel!
    @IBOutlet weak var explaination: UILabel!
    
    
}
