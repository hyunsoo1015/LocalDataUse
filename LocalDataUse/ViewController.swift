//
//  ViewController.swift
//  LocalDataUse
//
//  Created by 김현수 on 07/09/2020.
//  Copyright © 2020 Hyun Soo Kim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    
    @IBAction func moveInput(_ sender: Any) {
        //InputViewController를 화면에 출력
        
        //뷰 컨트롤러 객체를 생성
        let inputViewController = storyboard?.instantiateViewController(withIdentifier: "InputViewController") as! InputViewController
        //트랜지션(일정한 패턴으로 적용되는 애니메이션) 모양 설정
        inputViewController.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        present(inputViewController, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //데이터를 출력하는 코드
        
        //AppDelegate 객체에 대한 참조 가져오기
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        //데이터를 가져와서 출력
        lblName.text = appDelegate.name
        
        //환경 설정 파일에 저장한 데이터를 출력
        //환경 설정 파일에 대한 참조 가져오기
        let userDefaults = UserDefaults.standard
        //데이터를 가져와서 출력
        //email이라는 key에 데이터가 없으면
        //nil이 되고 예외가 발생
        //nil이 아닌 경우만 수행
        if let shareEmail = userDefaults.string(forKey: "email") {
            lblEmail.text = shareEmail
        }
        //swift 나 kotlin에서는 if 나 guard 안에서 변수를 만들어서 대입하는 경우
        //값이 nil 이면 false를 리턴하고 그렇지 않으면 true를 리턴
        
    }

    @IBOutlet weak var tfContent: UITextField!
    
    @IBAction func write(_ sender: Any) {
        //도큐먼트 디렉토리의 data.txt 파일에 tfContent에 입력한 내용을 기록하기
        
        //도큐먼트 디렉토리의 경로 만들기
        let docPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let docsDir = docPaths[0]
        
        //파일 경로 만들기
        let filePath = docsDir + "/data.txt"
        
        //입력한 내용 가져오기
        let contents = tfContent.text
        let data = contents?.data(using: .utf8)
        
        //파일 매니저 객체 생성
        let fileMgr = FileManager.default
        
        //파일에 기록
        fileMgr.createFile(atPath: filePath, contents: data, attributes: nil)
    }
    
    @IBAction func read(_ sender: Any) {
        //도큐먼트 디렉토리의 경로 만들기
        let docPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let docsDir = docPaths[0]
        
        //파일 경로 만들기
        let filePath = docsDir + "/data.txt"
        //파일 매니저 객체 만들기
        let fileMgr = FileManager.default
        
        //파일의 존재여부 확인
        var msg: String! = nil
        if fileMgr.fileExists(atPath: filePath) {
            //파일의 내용 읽기
            let databuffer = fileMgr.contents(atPath: filePath)
            msg = String(bytes: databuffer!, encoding: .utf8)
        } else {
            msg = "파일이 존재하지 않습니다."
        }
        //대화상자에 msg 출력
        let alert = UIAlertController(title: "파일읽기", message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        self.present(alert, animated: true)
    }
    
    @IBAction func remove(_ sender: Any) {
        //도큐먼트 디렉토리의 경로 만들기
        let docPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let docsDir = docPaths[0]
        
        //파일 경로 만들기
        let filePath = docsDir + "/data.txt"
        //파일 매니저 객체 만들기
        let fileMgr = FileManager.default
        
        //파일 삭제
        try! fileMgr.removeItem(atPath: filePath)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let bundleViewController = self.storyboard?.instantiateViewController(identifier: "BundleViewController") as! BundleViewController
        
        self.present(bundleViewController, animated: true)
    }
}

