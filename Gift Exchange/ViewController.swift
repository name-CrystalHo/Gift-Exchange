//
//  ViewController.swift
//  Gift Exchange
//
//  Created by Crystal Ho on 7/1/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    @IBOutlet weak var vwContainer: UIView!
    let myButton = UIButton()
    let myLabel = UILabel()
    let myTableView = UITableView()
    var listings = [Listing]()
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setUp()
    }
    func setUp(){
        setTableView()
        setAPI()
    }
    func setAPI(){
        EtsyAPI().getListings(completion:{ listings in
            DispatchQueue.main.async { //willswitch to main thread
                self.listings = listings
                self.myTableView.reloadData()
            }
        })
 
    }
    func setTableView(){
        myTableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(myTableView)//Just have to use this to show up
        myTableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        myTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        myTableView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        myTableView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        
        myTableView.delegate = self
        myTableView.dataSource = self //Called protocalls but kinda like interface
        //You have to tell them type of Cell for tableviews
        //Whenever "cell" is called, you will use this
        myTableView.register(ListingCell.self, forCellReuseIdentifier: "cell")
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    //Indexpath has a section and row, but we do not care about section
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let myCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ListingCell else{
            fatalError("we fucked up") //returns never which means never return.....
            //will crash if reaches here
        } //returns a cell
        myCell.title.text = self.listings[indexPath.row].title
        myCell.subTitle.text=self.listings[indexPath.row].description
        let id = self.listings[indexPath.row].listing_id
        EtsyAPI().getImages(id: id, completion: {images in
            DispatchQueue.main.async { //willswitch to main thread
                // Create URL into UIImage
                let imageUrlString = images[0].url_fullxfull
                let imageUrl = URL(string: imageUrlString)!
                let imageData = try! Data(contentsOf: imageUrl)
                let image = UIImage(data: imageData)
                myCell.myImageView.image = image
                }
            }
        )

        return myCell
    }
    
   // 10 items in the 1 section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listings.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let listing=listings[indexPath.row]
        let ds = DetailViewController(listing:listing)
        present(ds, animated: true, completion: nil)
    }

}
//    func test() {
//        doWorkThatTimesALongTime(completion: { string in
//            print("here")
//        })
//
//        doWorkThatTimesALongTime(completion: handleReallySlowWork)
//    }
//
//    func handleReallySlowWork(myString: String) {
//        print("here")
//    }
//
//    func doWorkThatTimesALongTime(completion: (String) -> Void) {
//        completion("connor")
//    }

//    func setUpButton(){
//        myButton.translatesAutoresizingMaskIntoConstraints = false
//        self.view.addSubview(myButton)
//        myButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
//        myButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
//        myButton.setTitle("click me", for: .normal)
//        myButton.addAction(.init(handler: {[weak self]_ in
//            guard let self = self else {
//                return
//            }
//            if self.myLabel.text == "Crystal is cool"{
//                self.myLabel.text = "Crystal is not cool"
//            }
//            else if self.myLabel.text == "Crystal is not cool" {
    //                self.myLabel.text = "Cryst;al is cool"
//            }
//            let myEtsyAPI = EtsyAPI()
//            myEtsyAPI.getListings()
//        }), for: .touchUpInside)
//    }
//    func setUpLabel(){
//        myLabel.translatesAutoresizingMaskIntoConstraints = false
//        self.view.addSubview(myLabel)
//        myLabel.bottomAnchor.constraint(equalTo: myButton.topAnchor, constant: -10).isActive = true
//        myLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
//        myLabel.text = "Crystal is cool"
//
//    }
