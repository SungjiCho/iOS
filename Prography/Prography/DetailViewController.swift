//
//  DetailViewController.swift
//  Prography
//
//  Created by 조성지 on 2020/03/01.
//  Copyright © 2020 조성지. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    
    
    @IBOutlet var spinner: UIActivityIndicatorView!
    @IBOutlet var wv: WKWebView!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblRating: UILabel!
    
    var mvo: MovieVO!  // 목록 화면에서 전달하는 영화 정보를 받을 변수
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // WKNavigationDelegate의 델리게이트 객체를 지정
        self.wv.navigationDelegate = self
        self.wv.uiDelegate = self as? WKUIDelegate
        
        lblTitle.text = mvo.title
        lblRating.text = "\(mvo.rating!)"
        callImgAPI()
    }
    
    // WKWebView를 이용하여 영화 이미지 보여주기
    func callImgAPI(){
        
        var imgPath: String?  // medium_cover_image 경로를 받을 변수
        
        // 1. 영화 이미지 API 호출을 위한 URI를 생성
        let url = "https://yts.mx/api/v2/movie_details.json?with_images=true&movie_id=\(self.mvo.id!)"
        let apiURI: URL! = URL(string: url)
        
        // 2. REST API 호출
        let apidata = try! Data(contentsOf: apiURI)
        do{
            // 3. JSON 객체를 파싱하여 NSDictionary 객체로 받음
            let apiDictionary = try JSONSerialization.jsonObject(with: apidata, options: []) as! NSDictionary
             
            // 4. 데이터 구조에 따라 차례대로 캐스팅하며 읽어온다.
            let data = apiDictionary["data"] as! NSDictionary
            let movie = data["movie"] as! NSDictionary
            imgPath = movie["medium_cover_image"] as? String
            
        } catch{
            NSLog("Parser Error!")
        }
        
        // 6. URLRequest 인스턴스를 생성한다.
        if let url = imgPath{
            if let urlObj = URL(string: url){
                let req = URLRequest(url: urlObj)
                self.wv.load(req)
            }else{  // URL 형식이 잘못되었을 경우에 대한 예외처리
                // 경고창 형식으로 오류 메시지를 표시해준다.
                let alert = UIAlertController(title: "오류", message: "잘못된 URL입니다", preferredStyle: .alert)
                
                let cancelAction = UIAlertAction(title: "확인", style: .cancel){ (_) in
                    // 이전 페이지로 되돌려보낸다.
                    _ = self.navigationController?.popViewController(animated: true)
                }
                alert.addAction(cancelAction)
                self.present(alert, animated: false, completion: nil)
            }
        }else{  // URL 값이 전달되지 않았을 경우에 대한 예외처리
            // 경고창 형식으로 오류 메시지를 표시해준다.
            let alert = UIAlertController(title: "오류", message: "필수 파라미터가 누락되었습니다.", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "확인", style: .cancel){ (_) in
                // 이전 페이지로 되돌려보낸다.
                _ = self.navigationController?.popViewController(animated: true)
            }
            alert.addAction(cancelAction)
            self.present(alert, animated: false, completion: nil)
        }
         
    }
    
}


// MARK: WKNavigationDelegate 프로토콜 구현
extension DetailViewController: WKNavigationDelegate{
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        self.spinner.startAnimating()  // 인디케이터 뷰의 애니메이션을 실행
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.spinner.stopAnimating()  // 인디케이터 뷰의 애니메이션을 중단
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        self.spinner.stopAnimating()  // 인디케이터 뷰의 애니메이션을 중단
        self.alert("이미지를 불러오지 못했습니다."){
            // 버튼 클릭 시, 이전 화면으로 되돌려 보낸다.
            _ = self.navigationController?.popViewController(animated: true)
        }
        
        // 경고창 형식으로 오류 메시지를 표시해준다.
        let alert = UIAlertController(title: "오류", message: "이미지를 불러오지 못했습니다.", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "확인", style: .cancel){
            (_) in
            // 이전 화면으로 되돌려 보낸다.
            _ = self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(cancelAction)
        self.present(alert, animated: false, completion: nil)
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        self.spinner.stopAnimating()
        self.alert("이미지를 불러오지 못했습니다."){
            // 버튼 클릭시, 이전 화면으로 되돌려 보낸다.
            _ = self.navigationController?.popViewController(animated: true)
        }
    }
}

// MARK: 심플한 경고창 함수 정의용 익스텐션
extension UIViewController{
    func alert(_ message: String, onClick: (() -> Void)? = nil){
        let controller = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "OK", style: .cancel){ (_) in onClick?()
        })
        DispatchQueue.main.async {
            self.present(controller, animated: false)
        }
    }
}
