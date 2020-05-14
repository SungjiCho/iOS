//
//  ViewController.swift
//  Prography
//
//  Created by 조성지 on 2020/03/01.
//  Copyright © 2020 조성지. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{

    var selectedItem = "" // 사용자에게 선택된 평점
    
    @IBOutlet var pickerRating: UIPickerView!
    @IBOutlet var lblRating: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // 피커 뷰의 컴포넌트 수 설정
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    // 피커 뷰의 개수 설정
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 10
    }
    // 피커 뷰의 각 행의 타이틀 설정
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(row)"
    }
    // 피커 뷰가 선택되었을 때 실행
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        lblRating.text = "\(row)"
        selectedItem = "\(row)"
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // 목적지 뷰 컨트롤러 인스턴스 읽어오기
        let dest = segue.destination
        
        guard let rvc = dest as? ListViewController else {
            return
        }
        // 값 전달
        rvc.paramRating = selectedItem
        
    }
    
    // 액티비티 인디케이터
    @IBAction func onBtnNext(_ sender: Any) {
        self.showSpinner()
    }

    
}
