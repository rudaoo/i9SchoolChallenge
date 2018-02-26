//
//  UIViewController+IPFUtils.m
//  ItauPfCS
//
//  Created by Itau on 6/11/15.
//  Copyright (c) 2015 Itau. All rights reserved.
//

#import "UIViewController+IPFUtils.h"

@implementation UIViewController (IPFUtils)
+(instancetype)initFromStoryboard:(NSString*)sbName{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:sbName bundle:nil];
    NSString *identifier = NSStringFromClass(self.class);
    return [sb instantiateViewControllerWithIdentifier:identifier];
}

@end
