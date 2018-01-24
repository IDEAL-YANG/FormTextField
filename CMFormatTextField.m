//
//  CMFormatTextField.m
//  Cmall
//
//  Created by apple on 16/5/24.
//  Copyright © 2016年 Moyun. All rights reserved.
//

#import "CMFormatTextField.h"

#define kUsableString @"0123456789aAbBcCdDeEfFgGhHiIjJkKlLmMnNoOpPqQrRsStTuUvVwWxXyYzZ\b"

@interface CMFormatTextField ()<UITextFieldDelegate>

@property (strong, nonatomic) UITextField *textField;

@end

@implementation CMFormatTextField

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.textField];
        [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(@0);
            make.leading.equalTo(@8);
            make.top.equalTo(@0);
        }];
    }
    return self;
}

#pragma mark - UITextFieldDelegate

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSString *text = [textField text];
    
    NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:kUsableString];
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([string rangeOfCharacterFromSet:[characterSet invertedSet]].location != NSNotFound) {
        return NO;
    }
    text = [text stringByReplacingCharactersInRange:range withString:string];
    text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *newString = @"";
    while (text.length > 0) {
        NSString *subString = [text substringToIndex:MIN(text.length, 4)];
        newString = [newString stringByAppendingString:subString];
        if (subString.length == 4) {
            newString = [newString stringByAppendingString:@" "];
        }
        text = [text substringFromIndex:MIN(text.length, 4)];
    }
    newString = [newString stringByTrimmingCharactersInSet:[characterSet invertedSet]];
    if (newString.length >= 20) {
        return NO;
    }
    [textField setText:newString];
    self.text  = [newString stringByReplacingOccurrencesOfString:@" " withString:@""];
    return NO;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    self.text = @"";
    return YES;
}

#pragma mark - Getters And Setters

- (UITextField *)textField{
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.delegate = self;
        _textField.keyboardType = UIKeyboardTypeASCIICapable;
        _textField.placeholder = LocalString(CmallPleaseEnterCouponNumber);
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _textField.textColor = HEXCOLOR(0x444444);
        [_textField becomeFirstResponder];
    }
    return _textField;
}

- (void)setText:(NSString *)text{
    _text = text;
    if (text == nil) {
        self.textField.text = @"";
    }
}

@end
