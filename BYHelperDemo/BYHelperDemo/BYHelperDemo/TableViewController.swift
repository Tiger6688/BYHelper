//
//  TableViewController.swift
//  BYHelperDemo
//
//  Created by ysq on 15/1/8.
//  Copyright (c) 2015年 ysq. All rights reserved.
//

import UIKit
import BYHelper

class TableViewController: UITableViewController {

    private var image : UIImage?
    
    override func viewDidLoad() {
        self.title = "Demo"
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 6
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let string = "Cell"
        var cell : UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(string) as? UITableViewCell
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: string)
        }
        
        cell?.textLabel?.text = testTitle(indexPath.row)
        
        cell?.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        if indexPath.row == 5{
            cell?.imageView?.image = image
        }else{
            cell?.imageView?.image = nil
        }
        
        return cell!
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.row{
        case 0:
            self.testDelay()
        case 1:
            self.testAlertBlock()
        case 2:
            self.testSheetBlock()
        case 3:
            self.testBYAlertController_Alert()
        case 4:
            self.testBYAlertController_Sheet()
        case 5:
            self.testPickerImage()
        default:
            return
        }
    }
    
    private func testTitle(row : NSInteger)->String{
        let titles = ["延迟任务","IOS7 UIAlertView闭包扩展","IOS7 UIActionSheet闭包扩展","ios 7 8适配的弹出视图 .Alert","ios 7 8适配的弹出视图 .ActionSheet","读取本地图片"]
        return titles[row]
    }
    
    private func testDelay(){
        delay(2, { () -> () in
            println("2秒后输出")
            return
        })
    }
    private func testAlertBlock(){

        var alert : UIAlertView = UIAlertView(title: "标题", message: "副标题",delegate:nil, cancelButtonTitle:"取消",otherButtonTitles: "确定")
        alert.show({ (index) -> Void in
            if index == 0{
                println("按了取消")
            }else{
                println("按了确定")
            }
        })
        
    }
    
    private func testSheetBlock(){
        var sheet = UIActionSheet(title: "", delegate: nil, cancelButtonTitle: "取消", destructiveButtonTitle: "删除", otherButtonTitles: "按钮1", "按钮2")
        sheet.showInView(self.view, finish: { (index) -> Void in
            println("按钮位置\(index)")
        })
    }
    
    private func testBYAlertController_Alert(){
        var alert = BYAlertController(title: "标题", message: "副标题", preferredStyle: .Alert, cancelButtonTitle: "取消", otherButtonTitles: "1","2","3")
        alert.showAlertViewInViewController(self, clickedCancelButton: { () -> () in
            println("按了取消")
        }) { (index) -> () in
            println("按了\(index+1)")
        }
    }
    private func testBYAlertController_Sheet(){
        var sheet = BYAlertController(title: "标题", message: "副标题", preferredStyle: .ActionSheet, cancelButtonTitle: "取消", otherButtonTitles: "1","2","3")
        sheet.showAlertViewInViewController(self, clickedCancelButton: { () -> () in
            println("按了取消")
            }) { (index) -> () in
                println("按了\(index+1)")
        }
    }
    
    private func testPickerImage(){
        var picker = UIImagePickerController()
        picker.showInViewController(self, finish: { (image) -> Void in
            self.image = image
            self.tableView.reloadData()
        })
    }
    

}

