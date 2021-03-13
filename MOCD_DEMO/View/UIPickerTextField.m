//
//  UIPickerTextField.m
//  instagram_app
//
//  Created by haya habbous on 12/25/17.
//  Copyright © 2017 haya habbous. All rights reserved.
//

#import "UIPickerTextField.h"

@implementation UIPickerTextField

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (CGRect) caretRectForPosition:(UITextPosition*) position
{
    return CGRectZero;
}

- (NSArray *)selectionRectsForRange:(UITextRange *)range
{
    return nil;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if (action == @selector(copy:) || action == @selector(selectAll:) || action == @selector(paste:))
    {
        return NO;
    }
    
    return [super canPerformAction:action withSender:sender];
}

@end
