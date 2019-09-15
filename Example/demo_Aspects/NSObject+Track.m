//
//  NSObject+Track.m
//  demo_Aspects_Example
//
//  Created by FelixPlus on 2019/9/15.
//  Copyright © 2019 Felix. All rights reserved.
//

#import "NSObject+Track.h"
#import <Aspects/Aspects.h>

@implementation NSObject (Track)

+ (void)load {
    
//    void (^block)() = ^() {
//        NSLog(@"%@ init", self);
//    };
    
    [UIViewController aspect_hookSelector:@selector(viewWillAppear:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo, BOOL animated) {
        NSLog(@"View Controller %@ will appear animated: %tu", aspectInfo.instance, animated);
    } error:NULL];
}

@end
