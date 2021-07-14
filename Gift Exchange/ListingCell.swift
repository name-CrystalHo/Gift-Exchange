//
//  ListingCell.swift
//  Gift Exchange
//
//  Created by Crystal Ho on 7/7/21.
//

import UIKit

class ListingCell:UITableViewCell{
    let title = UILabel()
    let subTitle = UILabel()
    let myImageView = UIImageView()
    let myStack = UIStackView()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) { //override will come with super
        super.init(style: style, reuseIdentifier: reuseIdentifier)  //will override default, call before
        setUp()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    func setUp(){
        setUpImageView()
        setUpStackView()
        setUpTitle()
        setUpSubTitle()
    }
    func setUpImageView(){
        //Don't have to use self, it know but I can keep it here
        myImageView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(myImageView)//Just have to use this to show up
        NSLayoutConstraint.activate([
            myImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            myImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            myImageView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            myImageView.widthAnchor.constraint(equalTo: self.contentView.heightAnchor)
        ])
    }
    func setUpStackView(){
    myStack.axis = .vertical
       myStack.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(myStack)//Just have to use this to show up
        NSLayoutConstraint.activate([
            myStack.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            myStack.leftAnchor.constraint(equalTo: myImageView.rightAnchor, constant: 10),
            myStack.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -10),
                
        ])
        
    }
    func setUpTitle(){
        myStack.addArrangedSubview(title)
        title.text = "Crystal is cool"

    }
    func setUpSubTitle(){
        myStack.addArrangedSubview(subTitle)
        subTitle.text = "Crystal is really cool because she is cool"
        
    }
}
