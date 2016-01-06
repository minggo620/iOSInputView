//
//  TestInputViewController.m
//  testInputView
//
//  Created by minggo on 16/1/5.
//  Copyright © 2016年 minggo. All rights reserved.
//

#import "TestInputViewController.h"
#import "FaceBoard.h"

@interface TestInputViewController ()<FaceBoardDelegate>

@property (weak, nonatomic) IBOutlet UITextView *testTv;
@property (weak, nonatomic) IBOutlet UIView *toolBarView;
- (IBAction)switchBt:(id)sender;

@end

@implementation TestInputViewController{
    FaceBoard *faceBoard;
    BOOL isKeyboard;
    BOOL isEmotionShow;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.toolBarView removeFromSuperview];
    self.testTv.inputAccessoryView = self.toolBarView;
    
    //isKeyboard = YES;
    if ( !faceBoard) {
        
        faceBoard = [[FaceBoard alloc] init];
        faceBoard.delegate = self;
        faceBoard.inputTextView = self.testTv;
    }
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardwillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardwillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];

}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
    isEmotionShow=NO;
    isKeyboard=NO;
}
- (void)textViewDidChange:(UITextView *)textView{
    
}
-(void)keyboardwillShow:(NSNotification *)notification{
    
}
-(void)keyboardwillHide:(NSNotification *)notification{
    
}

-(void)keyboardDidHide:(NSNotification *)notification{
    
    if (isEmotionShow||isKeyboard) {
        [self.testTv becomeFirstResponder];
    }else{
        
    }
}

- (IBAction)switchBt:(id)sender {
    UIButton *button = sender;
    
    if (!isEmotionShow) {
        [button setImage:[UIImage imageNamed:@"board_system"] forState:UIControlStateNormal];
        isEmotionShow = YES;
        isKeyboard = NO;
        self.testTv.inputView = faceBoard;
        [self.testTv resignFirstResponder];
        
    }else{
        [button setImage:[UIImage imageNamed:@"board_emoji"] forState:UIControlStateNormal];
        isEmotionShow = NO;
        isKeyboard = YES;
        self.testTv.inputView = nil;
        [self.testTv resignFirstResponder];
        
    }
}


@end
