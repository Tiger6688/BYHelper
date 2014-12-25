BYHelper
========

swift类库的扩展和继承，方便开发调用

## 持续更新 

###BYDelay

一个延迟执行的方法类

```swift
delay(2, { () -> () in
	println("2秒后执行")
})

let task = delay(1,{ () -> () in)
	println("已经取消了，永远进不来")
}
cancel(task)
```

###BYUIAlertViewBlock

提供UIAlertView的闭包扩展

```swift
var alert : UIAlertView = UIAlertView(title: "", message: text,delegate:nil, cancelButtonTitle:"取消",otherButtonTitles: "确定")
alert.show({ (index) -> Void in
	if index == 0{
		println("按了取消")
    }else{
    	println("按了确定")
    }
})
```

###BYUIImagePickerControllerBlock

提供获取相册图片的闭包扩展

```swift
var imagePickerController = UIImagePickerController()   imagePickerController.showInViewController(someVC, finish: { (image) -> Void in
    someImageView.image = image
    return
})
```

###BYUIViewExt

对UIView的扩展，提供了以下属性,方法

* vleft
* vright
* vtop
* vbottom
* vcenterX
* vcenterY
* vwidth
* vheight
* vsize
* removeAllSubviews()

###BYUIImageExt

对UIImage的扩展，使图片模糊化

* applyLightEffect()->UIImage?
* applyExtraLightEffect()->UIImage?
* applyDarkEffect()->UIImage?
* applyTintEffectWithColor(UIColor)->UIImage?
