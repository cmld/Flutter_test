//
//  ImagePickerViewController.swift
//  Runner
//
//  Created by yl on 2023/10/26.
//

import UIKit

class ImagePickerViewController: UIViewController, UINavigationControllerDelegate {
    
    var showImage: UIImageView = UIImageView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showImage.frame = self.view.frame
        showImage.contentMode = .scaleAspectFit
        self.view.addSubview(showImage)
        
        let button = UIButton(frame: CGRect(x: 0, y: UIScreen.main.bounds.maxY - 250, width: 100, height: 100))
        button.backgroundColor = .red
        button.setTitle("ImagePicker.image", for: .normal)
        button.addTarget(self, action: #selector(pushToImagePicker), for: .touchUpInside)
        self.view.addSubview(button)
        
    }
    
    @objc func pushToImagePicker()  {
        let imgPickerVC = UIImagePickerController()
        imgPickerVC.delegate = self
        imgPickerVC.sourceType = .camera // TODO: Armand 改变获取方式
        imgPickerVC.modalPresentationStyle = .fullScreen
        self.present(imgPickerVC, animated: true)
        
    }
}

extension ImagePickerViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let origianalImage = info[.originalImage] as? UIImage else {
            return
        }
        print("源图Info：\(origianalImage.size) \(toSizeK(tempImg: origianalImage))")
        DispatchQueue.global(qos: .default).async {[weak self] in
            let data = origianalImage.compressData(1)
            
            let show = self?.addWaterMerge(tempImg: UIImage(data: data ?? Data()) ?? UIImage()) ?? UIImage()
//            let temp = self?.addWaterMerge(tempImg: origianalImage) ?? UIImage()
//            let data = temp.compressData(1)
//            let show = UIImage(data: data ?? Data()) ?? UIImage()
            
            DispatchQueue.main.async {
                self?.showImage.image = show
            }
        }
        
        picker.dismiss(animated: true)
    }
    
    
    func addWater(tempImg: UIImage) -> UIImage {
        print("clmd-image: 原图大小 \(toSizeK(tempImg: tempImg))kb \(tempImg.size) - \(tempImg.scale)")
        
        let obliqueAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: tempImg.size.width/720 * 40), NSAttributedString.Key.foregroundColor: UIColor.gray]
        let temp = tempImg.obliqueWaterMark(markText: "J&T Express\nMalaysia Internal\nUse Only", attributes: obliqueAttributes)
        print("clmd-image: 加斜边水印后大小 \(toSizeK(tempImg:temp))kb \(temp.size) - \(temp.scale)")
        
        let textStyle = NSMutableParagraphStyle()
        textStyle.alignment = .center
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: tempImg.size.width/720 * 30), NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.paragraphStyle: textStyle] //
        let temp1 = temp.addWaterMark(markText: "31.654564,121.654654\n中国上海青浦区华东路来老师会计法1231号\n2023-11-56 18:23:23", attributes: attributes)
        print("clmd-image: 加文本水印后大小 \(toSizeK(tempImg:temp1))kb  \(temp1.size) - \(temp1.scale)")
        print(UIScreen.main.scale)
        return temp1
    }
    
    func addWaterMerge(tempImg: UIImage) -> UIImage {
        print("clmd-image: 原图大小 \(toSizeK(tempImg: tempImg))kb \(tempImg.size) - \(tempImg.scale)")
        
        let obliqueAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: tempImg.size.width/720 * 40), NSAttributedString.Key.foregroundColor: UIColor.gray]
        
        let textStyle = NSMutableParagraphStyle()
        textStyle.alignment = .center
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: tempImg.size.width/720 * 30), NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.paragraphStyle: textStyle]
        
        let temp = tempImg.waterMarkMerge(markText: "J&T Express\nMalaysia Internal\nUse Only", attributes: obliqueAttributes, content: "31.654564,121.654654\n中国上海青浦区华东路来老师会计法1231号\n2023-11-56 18:23:23", contentAttr: attributes)
        print("clmd-image: 加文本水印后大小 \(toSizeK(tempImg:temp))kb  \(temp.size) - \(temp.scale)")
        return temp
    }
    
    func toSizeK(tempImg: UIImage) -> Int {
        return (tempImg.jpegData(compressionQuality: 1)?.count ?? 0) / 1024
    }
}
