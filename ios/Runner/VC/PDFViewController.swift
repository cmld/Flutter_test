//
//  PDFViewController.swift
//  Runner
//
//  Created by yl on 2024/1/18.
//

import UIKit
import PDFKit
import HandyJSON

class PDFViewController: BaseViewController {
    
    var sourceData: [AddressModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pdfv = JTPdfShowView(frame: CGRect(x: 70, y: 70, width: kScreenWidth - 140, height: kScreenHeight-140))
        view.addSubview(pdfv)
        
        pdfv.openFile(fileName: "NDA_test")
        print(Date().description)
        
//        if let url = "省市区地址库.txt".fileUrl(), let fileContent = try? String(contentsOf: url, encoding: .utf8) {
//            let object = JSONDeserializer<tempModel>.deserializeFrom(json: fileContent)
//            
//            print(object?.content?.count)
//            print(Date().description)
//        }
        
//        if let url = "test_area.txt".fileUrl(),
//            let fileContent = try? String(contentsOf: url, encoding: .utf8),
//            let data = fileContent.data(using: String.Encoding.utf8),
//            let jsonObject = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
//            let dataArray = jsonObject as? [[String: Any]] {
//            for item in dataArray {
//                if let model = AddressModel.deserialize(from: item) {
//                    sourceData.append(model)
//                    print(model.children?.count)
//                }
//            }
//        }
    }
    
}

class JTPdfShowView: UIView, UIScrollViewDelegate {
    var scrollToEnd: (()->Void)?
    
    lazy var pdfView: PDFView = {
        let value = PDFView()
        value.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        value.displayMode = .singlePageContinuous
        value.autoScales = true
        return value
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(pdfView)
        pdfView.frame = CGRect(origin: .zero, size: frame.size)
    }
    
    func openFile(fileName: String) {
        // Load a PDF file
        if let path = Bundle.main.path(forResource: fileName, ofType: "pdf") {
            if let pdfDocument = PDFDocument(url: URL(fileURLWithPath: path)) {
                pdfView.document = pdfDocument
            }
        }
        if let scrollView = pdfView.subviews.first(where: {$0.isKind(of: UIScrollView.self)}) as? UIScrollView {
            scrollView.delegate = self
        }
    }
    
    // UIScrollViewDelegate method
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let bottomEdge = scrollView.contentOffset.y + scrollView.frame.size.height
        if bottomEdge >= scrollView.contentSize.height {
            // User has scrolled to the bottom
            print("Scrolled to the bottom")
        }
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return pdfView.documentView
    }
}

