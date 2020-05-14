//
//  ListViewController.swift
//  Prography
//
//  Created by 조성지 on 2020/03/01.
//  Copyright © 2020 조성지. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController {
    @IBOutlet var tvListView: UITableView!
    
    // 테이블 뷰를 구성할 리스트 데이터
    lazy var list: [MovieVO] = {
        var datalist = [MovieVO]()
        return datalist
    }()
    
    // 평점 값을 받을 변수
    var paramRating: String = ""
    // 현재까지 읽어온 데이터의 페이지 정보
    var page = 1
    
    // Next 버튼을 눌렀을 때 호출되는 메소드
    @IBAction func nextBtn(_ sender: UIBarButtonItem) {
        // 현재 페이지 값에 1을 추가한다.
        self.page += 1
        // 영화차트 API를 호출한다.
        self.callMovieAPI()
        // 데이터를 다시 읽어오도록 테이블 뷰를 갱신한다.
        self.tableView.reloadData()
    }
    
    // 뷰가 처음 메모리에 로드될 때 호출되는 메소드
    override func viewDidLoad() {
        super.viewDidLoad()
        // 영화차트 API를 호출한다.
        self.callMovieAPI()
    }
    
    // 영화 차트 API를 호출해주는 메소드
    func callMovieAPI(){
        // 1. 영화 API 호출을 위한 URI를 생성
        let url = "https://yts.mx/api/v2/list_movies.json?limit=10&sort=rating&page=\(self.page)&minimum_rating=\(self.paramRating)"
        let apiURI: URL! = URL(string: url)
        
        // 2. REST API 호출
        let apidata = try! Data(contentsOf: apiURI)
        
        // 3. JSON 객체를 파싱하여 NSDictionary 객체로 받음
        do{
            let apiDictionary = try JSONSerialization.jsonObject(with: apidata, options: []) as! NSDictionary
            
            // 5. 데이터 구조에 따라 차례대로 캐스팅하며 읽어온다.
            let data = apiDictionary["data"] as! NSDictionary
            let movies = data["movies"] as! NSArray
            
            // 6. Iterator 처리를 하면서 API 데이터를 MovieVO 객체에 저장한다.
            for row in movies{
                // 순회 상수를 NSDictionary 타입으로 캐스팅
                let r = row as! NSDictionary
                
                // 테이블 뷰 리스트를 구성할 때 데이터 형식
                let mvo = MovieVO()
                
                // movie 배열의 각 데이터를 mvo 상수의 속성에 대입
                mvo.id = r["id"] as? Int
                mvo.title = r["title"] as? String
                mvo.rating = r["rating"] as? Double
                
                // list 배열에 추가
                self.list.append(mvo)
            }
        } catch {
            NSLog("Parser Error!")
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 주어진 행에 맞는 데이터 소스를 읽어온다.
        let row = self.list[indexPath.row]
        
        // as! UITableViewCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell")!
        
        // 데이터 소스에 저장된 값을 각 아울렛 변수에 할당
        cell.textLabel?.text = row.title
        cell.detailTextLabel?.text = "\(row.rating!)"
        
        // 셀 객체를 반환
        return cell
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // 실행된 세그웨이와 식별자가 "movieDetail"이라면
        if segue.identifier == "movieDetail"{
            // sender 인자를 캐스팅하여 테이블 셀 객체로 변환한다.
            let cell = sender as! UITableViewCell
            // 사용자가 클릭한 행을 찾아낸다.
            let indexPath = self.tvListView.indexPath(for: cell)
            // API 영화 데이터 배열 중에서 선택된 행에 대한 데이터를 추출한다.
            let movieinfo = self.list[indexPath!.row]
            // 행 정보를 통해 선택된 영화 데이터를 찾은 다음, 목적지 뷰 컨트롤러의 mvo 변수에 대입한다.
            let detailView = segue.destination as! DetailViewController
            detailView.mvo = movieinfo
        }
    }
}
