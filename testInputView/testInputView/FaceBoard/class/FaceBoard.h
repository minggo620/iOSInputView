//
//  FaceBoard.h
//
//  Created by blue on 12-9-26.
//  Copyright (c) 2012年 blue. All rights reserved.
//  Email - 360511404@qq.com
//  http://github.com/bluemood


#import <UIKit/UIKit.h>

#import "FaceButton.h"

#import "GrayPageControl.h"


#define FACE_NAME_HEAD  @"/s"

// 表情转义字符的长度（ /s占2个长度，xxx占3个长度，共5个长度 ）
#define FACE_NAME_LEN   5


@protocol FaceBoardDelegate <NSObject>

@optional

- (void)textViewDidChange:(UITextView *)textView;

@end


@interface FaceBoard : UIView<UIScrollViewDelegate>{

    UIScrollView *faceView;

    GrayPageControl *facePageControl;

    NSDictionary *_faceMap;
}


@property (nonatomic, assign) id<FaceBoardDelegate> delegate;


@property (nonatomic, retain) UITextField *inputTextField;

@property (nonatomic, retain) UITextView *inputTextView;


- (void)backFace;


@end
