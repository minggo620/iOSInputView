# Using UITextView's inputView property to fix custom emotionji keyboard
[![Support](https://img.shields.io/badge/support-iOS%206%2B%20-blue.svg?style=flat)](https://www.apple.com/nl/ios/)&nbsp;
[![Travis](https://img.shields.io/travis/rust-lang/rust.svg)]()
[![GitHub release](https://img.shields.io/github/release/qubyte/rubidium.svg)]()
[![Github All Releases](https://img.shields.io/badge/download-6M Total-green.svg)](https://github.com/minggo620/iOSWelcomePage/archive/master.zip)

##Scenes:  
1.输入框的键盘消失后，焦点还在。  
2.输入框的能够显示表情。
3.获取输入框的内容时候，表情转换成对应字符串。
4.表情输入和系统键盘切换。

##Think:  
1.默认情况下，系统盘消失后`UITextView`，`UITextField`的焦点都会消失，这种情况不像Android开发可以单独呼出键盘和降下键盘，只能选择InputView。  
2.`UITextView`添加表情通过NSTextAttachment.image这个属性插入图片。  
3.显示了表情后，获取带表情内容需要切换成对应字符串，继承`NSTextAttachment`的子类多定义一个NSString类型emotionStr,在编写一个`NSAttributeString`的Category进行处理字符转换。  
4.切换系统键盘和表情键盘通过监听键盘的Show和Hide的通知，将`UITextView`或`UITextField`的InputView设置成nil。  
5.并且使用自定义的UIView作为`UITextView`，`UITextField`的`inputAccessoryView`属性作为切换键盘按钮。
##Step Processes:
1.以UITextview为例，在Storyboard设计UI如下图。  
![](https://github.com/minggo620/iOSInputView/blob/master/picture/inputview1.jpg)
