//
//  WZAddCommentViewController.m
//  Abalone
//
//  Created by 吾在 on 13-4-24.
//  Copyright (c) 2013年 吾在. All rights reserved.
//

#import "WZAddCommentViewController.h"
#import "WZCommentNetWorker.h"
#import "WZUser+Me.h"
#import "UIWindow+Lock.h"

@interface WZAddCommentViewController ()

@end

@implementation WZAddCommentViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
	self.title = @"添加评论";
    
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    UIBarButtonItem *closeItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(closeKeyboard:)];
    UIBarButtonItem *flexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    toolbar.items = @[flexible,closeItem];
    self.textView.inputAccessoryView = toolbar;
    self.textView.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendCommentSuccess:) name:SendCommentSuccess object:nil];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendCommentFail:) name:SendCommentFail object:nil];
}

-(void)closeKeyboard:(id)sender
{
    [self.textView  resignFirstResponder];
}

-(void)updateWordsNum
{
    NSString *textNum = [NSString stringWithFormat:@"%i/200",self.textView.text.length];
    self.wordNum.text = textNum;
}

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    CGRect frame = self.textView.frame;
    frame.size.height = 80;
    self.textView.frame = frame;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(languageChanged:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

-(void)textViewDidChange:(UITextView *)textView
{
    NSUInteger num = self.textView.text.length;
    if (num < 200) {
        [self updateWordsNum];
    }else{
        self.textView.text = [self.textView.text substringToIndex:200];
    }
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    CGRect frame = self.textView.frame;
    frame.size.height = 145;
    self.textView.frame = frame;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
}


-(void)languageChanged:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    NSValue *value1 = [userInfo valueForKey:UIKeyboardFrameBeginUserInfoKey];
    NSValue *value2 = [userInfo valueForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect frame1,frame2;
    [value1 getValue:&frame1];
    [value2 getValue:&frame2];
    CGFloat height = frame2.size.height - frame1.size.height;
    CGRect frame = self.textView.frame;
    frame.size.height -= height;
    self.textView.frame = frame;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    if (self.view.window == nil) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:SendCommentSuccess object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:SendCommentFail object:nil];
    }
   
}

- (IBAction)sendComment:(id)sender {
    
    NSString *cleanString = [self.textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (!cleanString.length) {
        [[[UIAlertView alloc]initWithTitle:@"提示" message:@"请输入有效数据 " delegate:nil  cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
        
    }else{
         [UIWindow lock];
        [WZCommentNetWorker  sendCommentByUser:[WZUser me] toMerchant:self.merchant withContent:cleanString andRating:@5];
    }
    
}

-(void)sendCommentSuccess:(NSNotification *)notification
{
    [UIWindow unlock];
    
    WZComment *comment = [[notification object] lastObject];
    comment.user = [WZUser me];
    comment.merchant = self.merchant;
    comment.commenterName = comment.user.name;
    comment.createdAt = [NSDate date];
    comment.content = [self.textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    comment.rating = @5;
    [[RKObjectManager sharedManager].objectStore save:nil];
    
    self.textView.text = nil;
    [[[UIAlertView alloc]initWithTitle:@"提示" message:@"感谢您的评论！ " delegate:nil  cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
}

-(void)sendCommentFail:(NSNotification *)notification
{
     [UIWindow unlock];
    [[[UIAlertView alloc]initWithTitle:@"提示" message:@"评论失败，请检查网络！" delegate:nil  cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
}


@end
