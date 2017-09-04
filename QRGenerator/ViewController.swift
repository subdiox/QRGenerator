//
//  ViewController.swift
//  QRGenerator
//
//  Created by subdiox on 2017/09/04.
//  Copyright © 2017年 Ooka-Dev. All rights reserved.
//

import UIKit
import CoreImage

class ViewController: UIViewController {

    @IBOutlet var qrTextField: UITextField!
    @IBOutlet var qrImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func generateQR(_ sender: Any) {
        
        // NSString から NSDataへ変換
        let data: Data = (qrTextField.text?.data(using: String.Encoding.utf8))!
        
        // QRコード生成のフィルター
        // NSData型でデーターを用意
        // inputCorrectionLevelは、誤り訂正レベル
        let qr = CIFilter(name: "CIQRCodeGenerator", withInputParameters: ["inputMessage": data, "inputCorrectionLevel": "M"])!
        
        
        let sizeTransform = CGAffineTransform(scaleX: 10, y: 10)
        let qrImage = qr.outputImage!.applying(sizeTransform)
        
        qrImageView.image = UIImage(ciImage: qrImage)
    }
}


extension UIViewController {
    // 外側をタップしてキーボードを隠す
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    // 編集終了
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
