//
//  ImagePickerViewController.swift
//  Runner
//
//  Created by yl on 2023/10/26.
//

import UIKit

class ImagePickerViewController: UIViewController, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        let button = UIButton(frame: CGRect(x: UIScreen.main.bounds.maxX - 100, y: UIScreen.main.bounds.maxY - 100, width: 100, height: 100))
        button.backgroundColor = .red
        button.setTitle("ImagePicker.image", for: .normal)
        button.addTarget(self, action: #selector(pushToImagePicker), for: .touchUpInside)
        self.view.addSubview(button)
        
        
        let button1 = UIButton(frame: CGRect(x: UIScreen.main.bounds.maxX - 250, y: UIScreen.main.bounds.maxY - 100, width: 100, height: 100))
        button1.backgroundColor = .blue
        button1.setTitle("location.SDK", for: .normal)
        button1.addTarget(self, action: #selector(pushToImagePicker1), for: .touchUpInside)
        self.view.addSubview(button1)
    }
    
    @objc func pushToImagePicker()  {
        let imgPickerVC = UIImagePickerController()
        imgPickerVC.delegate = self
        imgPickerVC.modalPresentationStyle = .fullScreen
        self.present(imgPickerVC, animated: true)
        
        
    }
    
    @objc func pushToImagePicker1()  {
//        JTLocationManager.shared.getLocation {[weak self] lon, lat in
//            print("获取到 {\(lon), \(lat)}")
//
//            JTLocationManager.shared.getAddress(lon: lon, lat: lat) { address in
//                print("获取到 {\(address)}")
//            }
//        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ImagePickerViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let origianalImage = info[.originalImage] as? UIImage else {
            return
        }
        print(origianalImage.size)
        picker.dismiss(animated: true)
    }
}
