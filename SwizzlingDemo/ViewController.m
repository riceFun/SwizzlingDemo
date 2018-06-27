//
//  ViewController.m
//  SwizzlingDemo
//
//  Created by riceFun on 2018/6/26.
//  Copyright © 2018年 riceFun. All rights reserved.
//

#import "ViewController.h"

#import "NSObject+RFSwizzling.h"

#import "Person.h"
#import "Animal.h"
#import "Chicken.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSError *error;
    
    //method swizzling
    Person *man = [[Person alloc]init];
    [man eatFood];
    [man takePhoto];
    [Person washCloth];
    [Person climbUpTree];
    
    NSLog(@"交换方法后");
    [Person rf_swizzleInstanceMethodWithOrigSel:@selector(eatFood) withNewSel:@selector(takePhoto) error:&error];
    [Person rf_swizzleClassMethodWithOrigSel:@selector(washCloth) withNewSel:@selector(climbUpTree) error:&error];
    
    [man eatFood];
    [man takePhoto];
    [Person washCloth];
    [Person climbUpTree];
    
    
    NSLog(@"---------------------------------------------------------");
    
    
    Animal *animal = [[Animal alloc]init];
    [animal eatFood];
    
    NSLog(@"交换isa后");
    [animal rf_setClass:[Chicken class] error:&error];//交换的两个类其大小需要相等 不然会崩溃
    [animal eatFood];
}

@end
