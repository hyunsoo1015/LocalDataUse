//
//  BundleViewController.swift
//  LocalDataUse
//
//  Created by 김현수 on 07/09/2020.
//  Copyright © 2020 Hyun Soo Kim. All rights reserved.
//

import UIKit
import WebKit
//여기서 에러가 나는 경우는 cocoa pods 설정과 podfile에
//의존성 설정이 제대로 되었는지 확인하고 프로젝트를 종료하고 다시 실행
import Alamofire

class BundleViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //화면 전체 크기 얻어오기
        let frame = UIScreen.main.bounds
        //웹 뷰 생성
        let webView = WKWebView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        
        //번들에 있는 Bluetooth.pdf 파일 경로 만들기
        let pdfPath = Bundle.main.path(forResource: "Bluetooth", ofType: "pdf")
        //URL로 변경
        let pdfURL = URL(fileURLWithPath: pdfPath!)
        //URLRequest로 변경
        let pdfRequest = URLRequest(url: pdfURL)
        //출력
        webView.load(pdfRequest)
        //현재 뷰에 웹 뷰를 추가
        self.view.addSubview(webView)
        
        //웹 서버에 파일을 업로드 하는 코드
        
        //파일을 제외한 파라미터를 생성
        let parameterS: Parameters = ["itemname": "아아", "description": "차가움", "price": "3000"]
        //업로드
        AF.upload(multipartFormData: {
            multipartFormData in
            //일반 파라미터 만들기
            for (key, value) in parameterS {
                if let temp = value as? String {
                    multipartFormData.append(temp.data(using: .utf8)!, withName: key)
                }
            }
            //파일 파라미터 만들기
            let image = UIImage(named: "musa.jpeg")
            multipartFormData.append(image!.jpegData(compressionQuality: 0.5)!, withName: "pictureurl",
                                     fileName: "file.jpeg", mimeType: "image/jpeg")
        }, to: "http://cyberadam.cafe24.com/item/insert", method: .post, headers: nil).validate(statusCode: 200..<300).responseJSON {
            response in
            //결과 출력
            NSLog(String(data: response.data!, encoding: .utf8)!)
        }
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
