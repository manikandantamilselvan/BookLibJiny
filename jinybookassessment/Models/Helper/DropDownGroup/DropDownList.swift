//
//  DropDown.swift
//  vv
//
//  Created by Sakthi on 15/12/14.
//  Copyright (c) 2014 Twelve77. All rights reserved.
//

import UIKit

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

// FIXME: comparison operators with optionals were removed from the Swift Standard Libary.
// Consider refactoring the code to use the non-optional operators.
fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


@objc class DropDownList: UIViewController, UITableViewDelegate, UITableViewDataSource, ICustomCellDelegate, UITextFieldDelegate,UISearchBarDelegate {
    

    @IBOutlet weak var mainViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableViewHeightConstraints: NSLayoutConstraint!
    
    @IBOutlet var viewTop: UIView!
    var doneButton: TargetButton  = TargetButton()
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var overLayButton: UIButton!
    @IBOutlet var cancelButtonOutlet: UIButton!
    @IBOutlet var lblNoResults: UILabel!
    
    @IBOutlet weak var mainViewHeightConstraints: NSLayoutConstraint!
    
    var selectedObject : ((DropDownEntity) -> ())?
    var ItemList : [DropDownEntity] = []
    var delegateCtrl : UIViewController!
    var titleText : String? = ""
    var filteredItemList : [DropDownEntity] = []
    
    fileprivate let fixedPrecentageofScreenSize : CGFloat = 60
    
    var selectedItemId:String?
    var navController: UINavigationController!

    var isFullScreenRequired =  false
    var drop_flag : String = ""
    var pageNavigates_flag : String = ""
    var completionHandlers: [(String?) -> Void] = []

//    init(delegate:UIViewController, calbackEventName : String, title:String = "" ) {
//        super.init(nibName: "DropDownList", bundle: nil)
//        delegateCtrl = delegate
//        rawEventName = calbackEventName
//        eventName = calbackEventName + ":"
//        titleText = title
//    }
//    init(listItems:NSArray?,withTitle title:String?, completion: @escaping (String?) ->Void ) {
//        super.init(nibName: "DropDownList", bundle: nil)
//        titleText = title
//        ItemList = listItems as! [DropDownEntity]
//        delegateCtrl = nil
//        completionHandlers.append(completion)
//
//    }

//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cellNib = UINib(nibName: "DropDownCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "dropdowncell")
        
        //cancelButtonOutlet.setTitle(textHelper.cancel, for: .normal)
//        let searchBar:UISearchBar = UISearchBar.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.size.width, height: 44))
//        searchBar.backgroundColor = UIColor.red
//        searchBar.searchBarStyle  = UISearchBar.Style.prominent
//        searchBar.placeholder     = " Search..."
//        searchBar.sizeToFit()
//        searchBar.isTranslucent   = false
//        searchBar.delegate        = self
//        searchBar.returnKeyType = UIReturnKeyType.done

//        self.tableView.tableHeaderView = searchBar
//        self.tableView.contentOffset = CGPoint.init(x: 0, y: 0)
        
//        lblNoResults.text = textHelper.make_search_empty
//        searchBar.placeholder = textHelper.serach_here_hint
        
        filteredItemList = ItemList
        lblTitle.text = titleText
        
        doneButton.selectedItem = ItemList[0]
        
        self.tableView.tableFooterView = UIView()
        lblNoResults.isHidden = true
        tableView.isHidden = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        var viewFrame = self.view.frame.height
        
        if let superView = self.presentingViewController {
            viewFrame = superView.view.frame.height
        }
        
        let ddViewsize  =  (viewFrame * self.fixedPrecentageofScreenSize)/100
        
        let cellframeHeight = self.tableView.dequeueReusableCell(withIdentifier: "dropdowncell")?.frame.size.height ?? 0
        
        let tblRowHeight = CGFloat(ItemList.count) * cellframeHeight
        
        if ddViewsize < tblRowHeight {
            self.tableViewHeightConstraints.constant = ddViewsize
        }else {
            self.tableViewHeightConstraints.constant = tblRowHeight
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchByString(searchText)
    }

    internal func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        //searchBar .setShowsCancelButton(true, animated: true)
    }
    
    func dismissSearchBar(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar .resignFirstResponder()
        searchBar.setShowsCancelButton(false, animated: true)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return filteredItemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell : DropDownCell = tableView.dequeueReusableCell(withIdentifier: "dropdowncell", for: indexPath) as! DropDownCell
        
        cell.eventDelegate = self
        cell.RowID = indexPath.row
        
        let fillItem = filteredItemList[indexPath.row]
        cell.lblItemText.text = fillItem.name!
        cell.imgItemIcon.isHidden = true
        cell.imgIconleft.isHidden = true
        cell.img_deleteInfo.isHidden = true
        cell.backgroundColor = UIColor.white
        if selectedItemId != nil {
            if fillItem.stringID == selectedItemId{
                cell.accessoryType = .checkmark
            }else {
                cell.accessoryType = .none
            }
        }
        
        cell.imgItemIconWidthConstraint.constant = 0
        cell.imgItemIconHeightConstraint.constant = 0
        
        if pageNavigates_flag == "profile"
        {
            cell.imgItemIconWidthConstraint.constant = 30
            cell.imgItemIconHeightConstraint.constant = 30
            
            if fillItem.isDeleted == true {
                cell.img_deleteInfo.isHidden = false
                cell.img_deleteInfo.image = UIImage(named: "delete-bg-sml")
            }
            
            if (fillItem.lefticon?.count > 0)
            {
//                ProfileImageView().displayProfileImage(imageUrl: fillItem.lefticon ?? "", imageView: cell.imgItemIcon)
            } else {
                cell.imgItemIcon.isHidden = false
                cell.imgItemIcon.image = UIImage(named: "userProfile")
            }
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let deleCtrl = delegateCtrl else {
            completionHandlers[0](filteredItemList[indexPath.row].name)
            dismiss(animated: true, completion: nil)
           return
        }
        print(deleCtrl)
        doneButton.selectedItem = filteredItemList[indexPath.row]
        doneSelection()

    }
    
    @IBAction func btnCancel_Click(_ sender: UIButton)
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ sender:UIButton , selectedRow : Int)
    {
        
        doneButton.selectedItem = filteredItemList[selectedRow]
    }
    
    func doneSelection(){
        delegateCtrl.dismiss(animated: true, completion: nil)
        
        if (delegateCtrl != nil) {
            if selectedObject != nil {
                selectedObject?(doneButton.selectedItem)
            }
//            NotificationCenter.default.post(name: Notification.Name(rawValue: rawEventName), object: doneButton)
//            NotificationCenter.default.removeObserver(delegateCtrl, name: NSNotification.Name(rawValue: rawEventName), object: nil)
        }
    }
    func showUsing(_ controller:UIViewController)
    {
        if(ItemList.count == 0)
        {
            NSLog("%@","Items cannot be zero length")
            return
        }
        
        self.providesPresentationContextTransitionStyle = true
        self.definesPresentationContext = true
        self.modalPresentationStyle=UIModalPresentationStyle.overCurrentContext
        
        controller.present(self, animated: true, completion: {
        })
    }
    func show()
    {
        if(ItemList.count == 0)
        {
            NSLog("%@","Items cannot be zero length")
            return
        }
        
        self.providesPresentationContextTransitionStyle = true
        self.definesPresentationContext = true
        self.modalPresentationStyle=UIModalPresentationStyle.overCurrentContext

        delegateCtrl.present(self, animated: true, completion: {
        })
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        searchByString("")
        return true
    }
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                                                 replacementString string: String) -> Bool
    {
        
        let originalText: NSString = textField.text! as NSString
        let proposedText: NSString = originalText.replacingCharacters(in: range, with: string) as NSString
        
        self.searchByString(proposedText as String)
        
        return true
    }
    
    func searchByString(_ searchString : String)
    {
        
        if(searchString.isEmpty)
        {
            filteredItemList =  ItemList
        }else{
            //filteredItemList =  ItemList.filter { c in c.name!.lowercased().contains(searchString.lowercased()) || (c.leftItemtext?.lowercased().contains(searchString.lowercased()))! }
            
            filteredItemList = ItemList.filter({ c in
                
                if c.leftItemtext == nil {
                    if c.name!.lowercased().contains(searchString.lowercased()) {
                        return true
                    }else {
                        return false
                    }
                }else {
                    if c.name!.lowercased().contains(searchString.lowercased()) || (c.leftItemtext?.lowercased().contains(searchString.lowercased()))! {
                        return true
                    }else {
                        return false
                    }
                }
                
            })
        }
        
        if(filteredItemList.count > 0)
        {
            lblNoResults.isHidden = true
            //tableView.isHidden = false
        }else{
            lblNoResults.isHidden = false
            //tableView.isHidden = true
        }
        
        tableView.reloadData()
    }
}
extension NSLayoutConstraint {
    /**
     Change multiplier constraint
     
     - parameter multiplier: CGFloat
     - returns: NSLayoutConstraint
     */
    func setMultiplier(multiplier:CGFloat) -> NSLayoutConstraint {
        
        NSLayoutConstraint.deactivate([self])
        
        let newConstraint = NSLayoutConstraint(
            item: firstItem,
            attribute: firstAttribute,
            relatedBy: relation,
            toItem: secondItem,
            attribute: secondAttribute,
            multiplier: multiplier,
            constant: constant)
        
        newConstraint.priority = priority
        newConstraint.shouldBeArchived = self.shouldBeArchived
        newConstraint.identifier = self.identifier
        
        NSLayoutConstraint.activate([newConstraint])
        return newConstraint
    }
}
