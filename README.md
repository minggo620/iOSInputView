# Using UITextView's inputView property to fix custom emotionji keyboard
[![Support](https://img.shields.io/badge/support-iOS%206%2B%20-blue.svg?style=flat)](https://www.apple.com/nl/ios/)&nbsp;
[![Travis](https://img.shields.io/travis/rust-lang/rust.svg)]()
[![GitHub release](https://img.shields.io/github/release/qubyte/rubidium.svg)]()
[![Github All Releases](https://img.shields.io/badge/download-6M Total-green.svg)](https://github.com/minggo620/iOSInputView/archive/master.zip)

##Scenes:  
#####1.输入框的键盘消失后，焦点还在。  
#####2.输入框的能够显示表情。  
#####3.获取输入框的内容时候，表情转换成对应字符串。  
#####4.表情输入和系统键盘切换。
***
##Think:  
#####1.默认情况下，系统盘消失后`UITextView`，`UITextField`的焦点都会消失，这种情况不像Android开发可以单独呼出键盘和降下键盘，只能选择InputView。  
#####2.`UITextView`添加表情通过NSTextAttachment.image这个属性插入图片。  
#####3.显示了表情后，获取带表情内容需要切换成对应字符串，继承`NSTextAttachment`的子类多定义一个NSString类型emotionStr,在编写一个`NSAttributeString`的Category进行处理字符转换。  
#####4.切换系统键盘和表情键盘通过监听键盘的Show和Hide的通知，将`UITextView`或`UITextField`的InputView设置成nil。  
#####5.并且使用自定义的UIView作为`UITextView`，`UITextField`的`inputAccessoryView`属性作为切换键盘按钮。
***
##Step Processes:
#####1.以UITextview为例，在Storyboard设计UI如下图。  
![](https://github.com/minggo620/iOSInputView/blob/master/picture/inputview1.jpg)  
#####2.关联自定义UIView作为inputAccessoryView和实例化表情面板    
	
	-(void)viewDidLoad {
    	[super viewDidLoad];
    	[self.toolBarView removeFromSuperview];//主要因为inputAccessoryView的view不能在storyboard  

    	self.testTv.inputAccessoryView = self.toolBarView;
    
    	//isKeyboard = YES;
    	if ( !faceBoard) {
        
        	faceBoard = [[FaceBoard alloc] init];
        	faceBoard.delegate = self;
        f	aceBoard.inputTextView = self.testTv;
    	}   
	} 
	
![](https://github.com/minggo620/iOSInputView/blob/master/picture/inputview2.jpg)
 
#####3.实现系统键盘的表情键盘 

	-(void)keyboardDidHide:(NSNotification *)notificati {
    
    	if (isEmotionShow||isKeyboard) {
        	[self.testTv becomeFirstResponder];
    	}

	}  

	-(IBAction)switchBt:(id)sender {
    	UIButton *button = sender;
    
    	if (!isEmotionShow) {
        	[button setImage:[UIImage imageNamed:@"board_system"] forState:UIControlStateNormal];
       		isEmotionShow = YES;
        	isKeyboard = NO;
        	self.testTv.inputView = faceBoard;
        	self.testTv resignFirstResponder];
        
    	}else{
        	[button setImage:[UIImage imageNamed:@"board_emoji"] forState:UIControlStateNormal];
        	isEmotionShow = NO;
        	isKeyboard = YES;
        	self.testTv.inputView = nil;
        	[self.testTv resignFirstResponder];
        
    	}
	}  
   
![](https://github.com/minggo620/iOSInputView/blob/master/picture/inputview3.jpg)  

#####4.UITextview插入图片   
   
	if (self.inputTextView){

        NSMutableString *faceString = [[NSMutableString alloc]initWithString:self.inputTextView.text];
        [faceString appendString:[_faceMap objectForKey:[NSString stringWithFormat:@"%03d", i]]];
    
        EmotionTextAttachment *emotionTextAttachment = [EmotionTextAttachment new];
        emotionTextAttachment.emotionStr = [_faceMap objectForKey:[NSString stringWithFormat:@"%03d", i]];
        emotionTextAttachment.image = [UIImage imageNamed:[NSString stringWithFormat:@"%03d", i]];
        //存储光标位置
        location = (int)self.inputTextView.selectedRange.location;
        //插入表情
        [self.inputTextView.textStorage insertAttributedString:[NSAttributedString attributedStringWithAttachment:emotionTextAttachment] atIndex:self.inputTextView.selectedRange.location];
        //光标位置移动1个单位
        self.inputTextView.selectedRange = NSMakeRange(location+1, 0);
        
        [delegate textViewDidChange:self.inputTextView];
	 }
  
![](https://github.com/minggo620/iOSInputView/blob/master/picture/inputview4.jpg)   
    
#####5.编写NSAttributedString的Catergory实现获取表情对应的字符串  
  
    @implementation NSAttributedString (Emotion)  

    -(NSString *) mgo_getPlainString {
    
    	NSMutableString *sourceString = [NSMutableString stringWithString:self.string];
    
    	__block NSUInteger index = 0;
    
    	[self enumerateAttribute:NSAttachmentAttributeName inRange:NSMakeRange(0, self.length) options:0 usingBlock:^(id value, NSRange range, BOOL *stop) {
       		if (value && [value isKindOfClass:[EmotionTextAttachment class]]) {
           		[sourceString replaceCharactersInRange:NSMakeRange(range.location + index, range.length) withString:((EmotionTextAttachment *) value).emotionStr];
            index += ((EmotionTextAttachment *) value).emotionStr.length - 1;
        }
    	}];
    
    	return sourceString;
    }
	@end

#####6.调用扩展方法   
   
    NSString *inputString;
    if ( self.inputTextView ) { 
    	inputString = [self.inputTextView.attributedText mgo_getPlainString]; 
    }

#####7.最终的效果如下
![](https://github.com/minggo620/iOSInputView/blob/master/picture/inputView.gif)   
