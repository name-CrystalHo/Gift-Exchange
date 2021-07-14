//
//  DetailViewController.swift
//  Gift Exchange
//
//  Created by Crystal Ho on 7/13/21.
//

import UIKit

class DetailViewController:UIViewController{
    let myImageView=UIImageView()
    let myButton=UIButton()
    let myDescription=UILabel()
    let myTitle=UILabel()
    let myStack = UIStackView()
    let listing:Listing //we do not know it yet
    init(listing:Listing){
        self.listing=listing
        super.init(nibName: nil, bundle: nil) //call this last, everything has to be initialized first
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        view.backgroundColor = .white
    }
    func setUp(){
        setUpImage()
        setUpStackView()//order matters for set up
        setUpTitle()
        setUpDescription()
        setUpNavButton()
        
    }
    func setUpImage(){ //UIPageControll
        myImageView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(myImageView)//Just have to use this to show up
        NSLayoutConstraint.activate([
            myImageView.topAnchor.constraint(equalTo: self.view.topAnchor),
            myImageView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            myImageView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            myImageView.heightAnchor.constraint(equalTo: self.view.widthAnchor)
        ])
        EtsyAPI().getImages(id: listing.listing_id, completion: {images in
            DispatchQueue.main.async { //willswitch to main thread
                // Create URL into UIImage
                let imageUrlString = images[0].url_fullxfull
                let imageUrl = URL(string: imageUrlString)!
                let imageData = try! Data(contentsOf: imageUrl)
                let image = UIImage(data: imageData)
                self.myImageView.image = image
                }
            }
        )
    }
    func setUpStackView(){
    myStack.axis = .vertical
       myStack.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(myStack)//Just have to use this to show up
        NSLayoutConstraint.activate([
            myStack.topAnchor.constraint(equalTo: self.myImageView.bottomAnchor,constant:10),
            myStack.bottomAnchor.constraint(lessThanOrEqualTo: self.view.bottomAnchor),
            myStack.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 10),
            myStack.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -10),
                
        ])
        
    }
    func setUpDescription(){
        myStack.addArrangedSubview(myDescription) ///adds to stack
        myDescription.text = listing.description
    }
    func setUpTitle(){
        myStack.addArrangedSubview(myTitle)
        myTitle.text = listing.title
    }
    func setUpNavButton(){
        myStack.addArrangedSubview(myButton)
        myButton.setTitleColor(.black, for: .normal)
        myButton.setTitle("click me", for: .normal)
        myButton.addAction(.init(handler: {[weak self]_ in
            guard let self=self,let url = URL(string: self.listing.url)else{
                return
            }
            UIApplication.shared.open(url, options:[:], completionHandler: nil)
        }), for: .touchUpInside)
    }
}
