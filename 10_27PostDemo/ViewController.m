//
//  ViewController.m
//  10_27PostDemo
//
//  Created by nate on 15/10/27.
//  Copyright (c) 2015年 nate. All rights reserved.
//

#import "ViewController.h"


#define Tag_Register 2000
#define Tag_Login 3000
#define Tag_UserName 4000
#define Tag_Password 5000

#define Screen_Width    [UIScreen mainScreen].bounds.size.width
#define Screen_Height   [UIScreen mainScreen].bounds.size.height

@interface ViewController () <UITextFieldDelegate>
{
    UITextField* userNameField;
    UITextField* pwdField;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initUI];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

-(void)initUI{
    
    UILabel* nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 140, 60, 44)];
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.text = @"账号：";
    [self.view addSubview:nameLabel];
    
    userNameField = [[UITextField alloc] initWithFrame:CGRectMake(70, 140, Screen_Width-140, 44)];
    
    //设置UITextField 委托
    userNameField.delegate = self;
    
    userNameField.tag = Tag_UserName;
    
    //设置键盘的类型（例如，数字键盘，英文键盘）
    // userNameField.keyboardType = UIKeyboardTypeNumberPad;
    
    //右下角键值类型
    userNameField.returnKeyType = UIReturnKeyDone;
    
    userNameField.backgroundColor = [UIColor whiteColor];
    
    //设置提醒信息
    userNameField.placeholder = @"请输入手机 / 邮箱";
    
    //设置清除标志
    userNameField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    userNameField.textAlignment = NSTextAlignmentCenter;
    
    //启动键盘，用户
    //[userNameField becomeFirstResponder];
    
    [userNameField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    [self.view addSubview:userNameField];
    
    UIView* line = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(nameLabel.frame), Screen_Width, 0.5)];
    line.backgroundColor = [UIColor redColor];
    [self.view addSubview:line];
    
    UILabel* pwdLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(nameLabel.frame)+0.5, 60, 44)];
    pwdLabel.backgroundColor = [UIColor clearColor];
    pwdLabel.text = @"密码：";
    [self.view addSubview:pwdLabel];
    
    pwdField = [[UITextField alloc] initWithFrame:CGRectMake(70, CGRectGetMaxY(userNameField.frame)+0.5, Screen_Width-140, 44)];
    
    pwdField.delegate = self;
    pwdField.backgroundColor = [UIColor whiteColor];
    pwdField.tag = Tag_Password;
    
    //[pwdField becomeFirstResponder];
    pwdField.returnKeyType = UIReturnKeyDone;
    pwdField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    pwdField.secureTextEntry = YES;
    
    pwdField.placeholder = @"请输入密码";
    
    pwdField.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:pwdField];
    
    UIButton* btnRegister = [self creatButtonWithName:@"登 录" tag:Tag_Login frame:CGRectMake(60, 260, Screen_Width-120, 44)];
    
    [self creatButtonWithName:@"注 册" tag:Tag_Register frame:CGRectMake(60, CGRectGetMaxY(btnRegister.frame)+10, Screen_Width-120, 44)];
    
    
    
}

#pragma mark- UITextFieldDelegate

-(void)textFieldDidChange:(UITextField*)textField{
    
}

// return NO to not change text

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    return YES;
}

// called when clear button pressed. return NO to ignore (no notifications)
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    switch (textField.tag) {
        case Tag_UserName:
        {
            UITextField*  user = (UITextField*)[self.view viewWithTag:Tag_UserName];
            
            NSLog(@"userName=%@",user.text);
            
            if ([user canResignFirstResponder]) {
                [user resignFirstResponder];
            }
            //
            UITextField*  pwd = (UITextField*)[self.view viewWithTag:Tag_Password];
            
            if ([pwd canResignFirstResponder]) {
                [pwd becomeFirstResponder];
            }
            
        }
            break;
        case Tag_Password:
        {
            //关闭键盘
            [textField resignFirstResponder];
        }
            break;
        default:
            break;
    }
    
    
    return YES;
}


-(UIButton*)creatButtonWithName:(NSString*)title tag:(NSInteger)tagIndex frame:(CGRect)rect{
    
    //UIButton* btn = [[UIButton alloc] initWithFrame:rect];
    
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = rect;
    
    btn.backgroundColor = [UIColor redColor];
    btn.layer.cornerRadius = 5.0f;
    [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = tagIndex;
    [btn setTitle:title forState:UIControlStateNormal];
    
    [self.view addSubview:btn];
    return btn;
}

-(void)btnClicked:(id)sender{
    
    if (userNameField.text.length<=0 || pwdField.text.length<=0) {
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"警告" message:@"账号或者密码不能为空！！！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }
    
    if (sender && [sender isKindOfClass:[UIButton class]]) {
        UIButton* btn = (UIButton* )sender;
        
        switch (btn.tag) {
            case Tag_Register:
            {
                [[EngineInterface shareInstances] regist:userNameField.text pwd:pwdField.text];
                userNameField.text = @"";
                pwdField.text = @"";
                [pwdField resignFirstResponder];
            }
                break;
            case Tag_Login:
            {
                
                [[EngineInterface shareInstances] login:userNameField.text pwd:pwdField.text];
                userNameField.text = @"";
                pwdField.text = @"";
                [pwdField resignFirstResponder];
                
            }
                break;
                
            default:
                break;
        }
    }
}
@end
