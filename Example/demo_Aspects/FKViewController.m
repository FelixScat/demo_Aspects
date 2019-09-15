//
//  FKViewController.m
//  demo_Aspects
//
//  Created by Felix on 09/15/2019.
//  Copyright (c) 2019 Felix. All rights reserved.
//

#import "FKViewController.h"
#import <Aspects/Aspects.h>

@interface FKViewController ()

@property (nonatomic, strong) id<AspectToken> token;

@end

@implementation FKViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    __weak typeof(self) weakSelf = self;
    _token = [self aspect_hookSelector:@selector(giveMeFive) withOptions:AspectPositionInstead usingBlock:^(id<AspectInfo> info) {
        // Call original implementation.
        NSNumber *number;
        NSInvocation *invocation = info.originalInvocation;
        [invocation invoke];
        [invocation getReturnValue:&number];
        
        if (number) {
            number = @(10);
            [invocation setReturnValue:&number];
            [weakSelf.token remove];
        }
        
    } error:NULL];
}

- (NSNumber *)giveMeFive {
    return @(5);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    NSLog(@"%@", [self giveMeFive]);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
