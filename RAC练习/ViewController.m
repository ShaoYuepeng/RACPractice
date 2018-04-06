//
//  ViewController.m
//  RAC练习
//
//  Created by 邵岳鹏 on 2018/4/6.
//  Copyright © 2018年 邵岳鹏. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveCocoa.h>
@interface ViewController ()<UITextFieldDelegate>{
    
}

@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    //信号量监听
//    [self.userFile.rac_textSignal subscribeNext:^(id x) {
//        NSLog(@"%@",x);
//    }];
    //实现对一个输入框的控制
//    RACSignal *enableSignal = [self.userFile.rac_textSignal map:^id(NSString* value) {
//        return @(value.length > 0);
//    }];
    //信号量合并
    RACSignal *enableSignal = [[RACSignal combineLatest:@[self.userFile.rac_textSignal,self.psdFile.rac_textSignal]]map:^id(id value) {
        NSLog(@"%@",value);
        
        return @([value[0] length] > 0 && [value[1] length] > 6);
    }];
    
    self.loginBtn.rac_command = [[RACCommand alloc] initWithEnabled:enableSignal signalBlock:^RACSignal *(id input) {
        
        return [RACSignal empty];
    }];
}
/**传统做法
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.userFile setDelegate:self];
    [self.psdFile setDelegate:self];
    self.loginBtn.enabled = NO;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSString *str = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSString *s1 = self.userFile.text;
    NSString *s2 = self.psdFile.text;
    if (textField == self.userFile) {
        s1 = str;
    }else{
        s2 = str;
    }
    NSLog(@"用户名:%@密码%@",s1,s2);
    if (s1.length > 0 && s2.length > 6) {
        self.loginBtn.enabled = YES;
    }else{
        self.loginBtn.enabled = NO;
    }
 
    return YES;

 }
*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
