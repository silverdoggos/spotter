//
//  CameraViewController.swift
//  spotter
//
//  Created by Артём Шишкин on 24.12.2019.
//  Copyright © 2019 Артём Шишкин. All rights reserved.
//

import UIKit
import CoreML
import Vision
import Social

class CameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var name: String?
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tryAgainButton: UIButton!
    
    @IBOutlet weak var label: UILabel!
    let cameraView = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tryAgainButton.layer.cornerRadius = tryAgainButton.frame.height / 5
        tryAgainButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        tryAgainButton.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        tryAgainButton.layer.shadowOpacity = 1.0
        tryAgainButton.layer.shadowRadius = 5.0
        tryAgainButton.layer.masksToBounds = false
        tryAgainButton.isHidden = true
        
        print(name!)
        
        cameraView.delegate = self
        
        cameraView.sourceType = .camera
        cameraView.allowsEditing = false
        
        present(cameraView, animated: true, completion: nil)
        
        // Do any additional setup after loading the view.
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[.originalImage] as? UIImage {
            
            imageView.image = image
            
            cameraView.dismiss(animated: true, completion: nil)
            
            guard let ciImage = CIImage(image: image) else {
                fatalError("couldn't convert uiimage to CIImage")
            }
            detect(image: ciImage)
            
        }
        
    }
    
    func detect(image: CIImage) {
        
        // Load the ML model through its generated class
        guard let model = try? VNCoreMLModel(for: Inceptionv3().model) else {
            fatalError("can't load ML model")
        }
        
        let request = VNCoreMLRequest(model: model) { request, error in
            guard let results = request.results as? [VNClassificationObservation],
                let topResult = results.first
                else {
                    fatalError("unexpected result type from VNCoreMLRequest")
                }
            print(topResult)
            if topResult.identifier.contains(self.name!) {
                    DispatchQueue.main.async {
                        self.label.text = "Ты нашел!! Молодец!"
                        self.tryAgainButton.isHidden = self.tryAgainButton.isHidden ? true: true
                    }
                }
                else {
                    DispatchQueue.main.async {
                        self.label.text = "Попробуй еще!"
                        self.tryAgainButton.isHidden = false
                    }
                }
                
            
        }
        
        let handler = VNImageRequestHandler(ciImage: image)
        
        do { try handler.perform([request]) }
        catch { print(error) }
        
        
        
    }
    
    @IBAction func pressedTryAgain(_ sender: Any) {
    cameraView.delegate = self
        
        cameraView.sourceType = .camera
        cameraView.allowsEditing = false
        
        present(cameraView, animated: true, completion: nil)
        
    }
    
}
