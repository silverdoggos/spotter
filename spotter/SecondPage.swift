//
//  SecondPage.swift
//  spotter
//
//  Created by Артём Шишкин on 20.12.2019.
//  Copyright © 2019 Артём Шишкин. All rights reserved.
//

import UIKit

class SecondPage: UICollectionViewController{
    
    var location: Int?
    
    var name = ""
    
    let imageList: [[String]] = [[], ["clock", "bottle", "broom", "computer", "extractor", "fan", "jug", "mixed",  "portrait" ], ["buildings", "cable-car", "cementery", "factory", "forbbiden", "gate", "grocery-store", "house"]]
    

    
    
    override func viewDidLoad() {
    super.viewDidLoad()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageList[location!].count
    }
    
    override func collectionView(_  collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let text = imageList[location!][indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ItemCell
        

        
        cell.image.image = UIImage.init(named: imageList[location!][indexPath.row])
        cell.label.text = text
        
        cell.layer.cornerRadius = cell.frame.height / 5
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as? HeaderView{
            sectionHeader.title.alpha = 90.0
            return sectionHeader
        }
        return UICollectionReusableView()
    }
    
     
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.cellForItem(at: indexPath)?.alpha = 0.4
        name = imageList[location!][indexPath.row]
        performSegue(withIdentifier: "goToCamera", sender: self)
        
        }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! CameraViewController
        destinationVC.name = name
        
    }

}




