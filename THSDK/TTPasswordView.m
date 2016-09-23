//
//  TTPasswordView.m
//  TTPassword
//
//  Created by ttcloud on 16/6/20.
//  Copyright © 2016年 ttcloud. All rights reserved.
//

#import "TTPasswordView.h"
#import "THNetworkTool.h"
@interface TTPasswordView ()
{
    THNetworkTool *tool;
}
@end


@implementation TTPasswordView

- (NSMutableArray *)dataSource {
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray arrayWithCapacity:self.elementCount];
    }
    return _dataSource;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        tool = [THNetworkTool shareTool];
        
        
        PowerEnterUITextField *textField = [[PowerEnterUITextField alloc] initWithFrame:self.bounds];
        textField.hidden = YES;
        
        textField.passwordKeyboardType = Full;
        textField.secureTextEntry = YES;
        textField.isRoundam = YES;
        textField.timestamp = @"aaaaaaaaa";
        textField.platformPublicKey = kKeyboardPublickey;
        [textField addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
        [self addSubview:textField];
        self.textField = textField;
        self.textField.tag=20;
        __weak TTPasswordView *weakself = self;
        self.textField.inputContentsChanged = ^(PowerEnterUITextField *textField){
            
            NSInteger length = [textField.text length];
            PowerEnterUITextField *tf = _dataSource[length - 1];
            tf.text = @"*";
            if (length == 6) {
                [weakself.textField resignFirstResponder];
                [tool getTokenBlock:^(NSString *token) {
                    [tool POSHttpURL:@"trsPwdValidate" params:@{@"pin_data":weakself.textField.value,@"resToken":token} success:^(NSDictionary *result) {
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"POPPASSWORDVIEWREMOVE" object:textField.value];
                    }];
                }];
                
            }
        };
        [self.textField becomeFirstResponder];
        
    }
    return self;
}

- (void)setElementCount:(NSUInteger)elementCount {
    _elementCount = elementCount;
    for (int i = 0; i < self.elementCount; i++)
    {
        PowerEnterUITextField *pwdTextField = [[PowerEnterUITextField alloc] init];
        pwdTextField.layer.borderColor = _elementColor.CGColor;
        pwdTextField.enabled = NO;
        pwdTextField.tag=i+1;
        pwdTextField.backgroundColor=[UIColor whiteColor];
        pwdTextField.textAlignment = NSTextAlignmentCenter;
//        pwdTextField.secureTextEntry = YES;//设置密码模式
        pwdTextField.borderStyle = UITextBorderStyleLine;
//        pwdTextField.layer.borderWidth = 0.5;
        pwdTextField.userInteractionEnabled = NO;
        pwdTextField.placeholder = @"";
        [self insertSubview:pwdTextField belowSubview:self.textField];
        [self.dataSource addObject:pwdTextField];
    }
}
-(void)setNoSecure
{
    for (PowerEnterUITextField *text in self.subviews) {
        /**
         *  除了父输入框，其余输入框键盘全部设置明文
         */
        if (text.tag!=20) {
            text.secureTextEntry=YES;
        }
    }
}
- (void)setElementColor:(UIColor *)elementColor {
    _elementColor = elementColor;
    for (NSUInteger i = 0; i < self.dataSource.count; i++) {
        PowerEnterUITextField *pwdTextField = [_dataSource objectAtIndex:i];
        pwdTextField.layer.borderColor = self.elementColor.CGColor;
    }
}


- (void)setElementMargin:(NSUInteger)elementMargin {
    _elementMargin = elementMargin;
    [self setNeedsLayout];
}

- (void)clearText {
    self.textField.text = nil;
    [self textChange:self.textField];
}

#pragma mark - 文本框内容改变
- (void)textChange:(UITextField *)textField {
    NSString *password = textField.text;
    if (password.length > self.elementCount) {
        return;
    }
    
    for (int i = 0; i < _dataSource.count; i++)
    {
        PowerEnterUITextField *pwdTextField= [_dataSource objectAtIndex:i];
        if (i < password.length) {
            NSString *pwd = [password substringWithRange:NSMakeRange(i, 1)];
            pwdTextField.text = pwd;
        } else {
            pwdTextField.text = nil;
        }
        
    }
    
    if (password.length == _dataSource.count)
    {
        [textField resignFirstResponder];//隐藏键盘
    }
    
    !self.passwordBlock ? : self.passwordBlock(textField.text);
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = (self.bounds.size.width) / self.elementCount;
    CGFloat h = self.bounds.size.height;
    for (NSUInteger i = 0; i < self.dataSource.count; i++) {
        PowerEnterUITextField *pwdTextField = [_dataSource objectAtIndex:i];
        x = i * (w + self.elementMargin);
        pwdTextField.frame = CGRectMake(x, y, w, h);
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.textField becomeFirstResponder];
    if ([self.textField.text length] == 6) {
        [self clearText];
    }
}



@end
