//
//  DetailViewController.swift
//  Gift Exchange
//
//  Created by Crystal Ho on 7/13/21.
//

import UIKit

class DetailViewController:UIViewController{
    let myImageView=UIImageView()
    var currentIndex=0
    var UIImages:[UIImage]=[]
    let backButton=UIButton()
    let nextButton=UIButton()
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
        setUpImageButtons()
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
               
                var circleLayers:[CAShapeLayer]=[]
                for image in images{
                    let imageUrlString = image.url_fullxfull
                    let imageUrl = URL(string: imageUrlString)!
                    let imageData = try! Data(contentsOf: imageUrl)
                    let myUIImage = UIImage(data: imageData)
                    self.UIImages.append(myUIImage!)
                }
                self.myImageView.image = self.UIImages[self.currentIndex]
                }
            }
        )
    }
    func setUpImageButtons(){
        self.view.addSubview(backButton)
        self.view.addSubview(nextButton)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        
        backButton.setTitleColor(.black, for: .normal)
        backButton.setTitle("<", for: .normal)
        nextButton.setTitleColor(.black, for: .normal)
        nextButton.setTitle(">", for: .normal)
        NSLayoutConstraint.activate([
            nextButton.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            backButton.leftAnchor.constraint(equalTo: self.view.leftAnchor),
        ])
        
        nextButton.addAction(.init(handler: {[weak self]_ in
            guard let self = self else {
                return
            }
            self.currentIndex+=1
            if self.currentIndex == self.UIImages.count{
                self.currentIndex=0
            }
            else if self.currentIndex == -1{
                self.currentIndex=self.UIImages.count-1
            }
            self.myImageView.image = self.UIImages[self.currentIndex]
        }), for: .touchUpInside)
        
        backButton.addAction(.init(handler: {[weak self]_ in
            guard let self = self else {
                return
            }
            self.currentIndex-=1
            if self.currentIndex == self.UIImages.count{
                self.currentIndex=0
            }
            else if self.currentIndex == -1{
                self.currentIndex=self.UIImages.count-1
            }
            self.myImageView.image = self.UIImages[self.currentIndex]

        }), for: .touchUpInside)
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
